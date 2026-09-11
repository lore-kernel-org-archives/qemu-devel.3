Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B368C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAr-0005NT-6a; Fri, 11 Sep 2026 05:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA9-0003yk-32
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA7-0008H7-Kq
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBiB/jOHXjADUICu4zFhNVY6emnuWrVA0Kv/cK2oUiY=;
 b=VAI9wnxvEjP2DqmIBCS4EOC6BXJHfs3AZeszW0YvEUFq/3/lj5X9ArKqZPUWo3cocZHQWP
 hNczlOe1lBIZCJIZC8xvKEERPaJyEdwcHyi6L8ztxFMh2Wi++ri2vOJ2hIu+qhfCA3EH2E
 YACPUyiiwyGrBlTFJvtN/RPc2IIgyQY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-lu2vwWRsOBa2_FtQQQMWlg-1; Fri, 11 Sep 2026 05:03:09 -0400
X-MC-Unique: lu2vwWRsOBa2_FtQQQMWlg-1
X-Mimecast-MFC-AGG-ID: lu2vwWRsOBa2_FtQQQMWlg_1789117388
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso1175345e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117388; x=1789722188; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mBiB/jOHXjADUICu4zFhNVY6emnuWrVA0Kv/cK2oUiY=;
 b=WbetaV+U3BEjHvAo6llIpU9R1OSf1pRpiXzkuzDgnkn/2juV4HUI1rL+EKuxtTNeLN
 Fc9IecOaWIeg5wBanjxOBJwt5pjWPfTPxQxI3CNpFYL1U981fpfKQwJ23kCAsMAcSA3K
 t4MtI8y087lpJHn/dSSQiXlO1rXNU+ZRyKIglNjAwVhj6BEdZfy2pyNn0VnkFd7usj9Q
 xFd7koLKh/rDm1Kh+oNbgIvnSReRQGbWVhpmJmgZj1OR6QE2Px9WZBUK2TncqIUbzn1T
 yq24Pq2/qb8hfASF4sme6Y5LfzLdWjhEBrkq9nXvsl8d0Kd4Q+mQFdPCgeLaPE/eYswW
 VV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117388; x=1789722188;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mBiB/jOHXjADUICu4zFhNVY6emnuWrVA0Kv/cK2oUiY=;
 b=D5VNsEIGD6Lo57Q8YyRimFXtufZaDZhAemBoEpC6jgBNK+Pv3rToIF24woGjpiUddO
 7b1xQRYB4JKVE7mbflXZI0kQsydA4qNGe+9/1WXwSwmhsEORoGsnKTGowM3s99IGQTpO
 C1x8hf8by98X5YB4Slkzz+jupzwvlMgDeCPzM0qhmhx4CdhReH2PGiidhyBZxujmGPC1
 DcjkZ/ItkuWOjW9dmsFpINNpwLMTe51jrVV/VZ6LJ19cALaZxqL3WJt3U8u/w4h7NtBn
 4dSzEOaQqfipnwgRTKHe+25kG6uKWUbo5qTmDCKoFTbb1Sw2gOFxh6Znio8BmP8NQdn+
 5IWA==
X-Gm-Message-State: AFuF++k9Wf53YRcbiiZhRV3cTc3KdbYVFTOEB3mWdmZSrC++ehpJ5xMg
 coUmg5VyVggJUpH+W2cbOiyblUU93hTeQh0D6NNJTiIxB/aEtch4V0iQlwzHfyZZiX/vbE8Pe0q
 iqHH9ES4frr7cXEpYH7j4BAk6WGa3AIZ5zl0OXmmxeiBKFZlZEOHeGdYR1SWVCuIhJh43MVFlPI
 P5h4q9Uzew1Os/vowNOVx9TdieRmeChF5JyQ==
X-Gm-Gg: AYBFou2s66E/OvoJJtNp1u+sIHE5RqdmNpFRBfBsyotta/uC1FJbXApmAUxH8r4ltcN
 MNctmV27fe0+LU4oaT+jXLWrSUyd66TuJ1wvUeSn4aGp5R/VHT8IZPmn9B8YToxVo1VY8U3fkF1
 gHHc6/zvQwK1P78EJcQKlWxXWpkLoKACod16rY2ND1IONFz+AIIdkBt7F5HKnscTT0TlEV03Cco
 wW9RcogMCKBv35GbN0NXsoPEQapP4Y4augpHWpXUyj2FaizRW4zDj4SMFH8KSpjZ6kEdX9o49p3
 7IREU9I1pFwpYn5+IVNqIAAw9FMa6AE02zM3C7OJqj4E1MxBwFNfVJDRGzQrQHTyLWVufLxh08g
 8YM2swC21pwkiXNX2VlzA59Y=
X-Received: by 2002:a05:600c:3484:b0:49d:433:c3b6 with SMTP id
 5b1f17b1804b1-49e619d1eb8mr34384855e9.27.1789117388147; 
 Fri, 11 Sep 2026 02:03:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3484:b0:49d:433:c3b6 with SMTP id
 5b1f17b1804b1-49e619d1eb8mr34383725e9.27.1789117387249; 
 Fri, 11 Sep 2026 02:03:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm4589243f8f.19.2026.09.11.02.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:06 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 45/75] tests/acpi: x86: Allow IVRS acpi table changes
Message-ID: <324c0a70b9a3763d8b0df63929251e1e25264d39.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sairaj Kodilkar <sarunkod@amd.com>

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-3-sarunkod@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..33e9981655 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+tests/data/acpi/x86/q35/IVRS.ivrs
-- 
MST


