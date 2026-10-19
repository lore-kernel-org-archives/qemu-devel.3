Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E6ECCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjQZ-0004aW-2e; Mon, 19 Oct 2026 05:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xIjQW-0004Xp-2c
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xIjQU-0001vi-4o
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792401181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62oqdDj8dlT0pxuHt5cHb69+lEDkeWcIgt+nbW9frLw=;
 b=T/bEv/uJuBvVM5FMyYIx6o2YEgdq0c8Sts07fZA2RDgBL39KZs1aY0c1TMXsHtoXGVk/LF
 mtWIp2eOoHu0P8KV4jK+Neta2bFc5guckwDQUkCviW51mOZ8LIRvTFZBTPs2LDg22YVLBd
 wCH+BPO5MkeLpBTFRAr8Arwo+D1bpSY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-jZfbxhefNauK77LMMe52OQ-1; Mon, 19 Oct 2026 09:13:00 +0000
X-MC-Unique: jZfbxhefNauK77LMMe52OQ-1
X-Mimecast-MFC-AGG-ID: jZfbxhefNauK77LMMe52OQ_1792401179
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0389d6f9so1223058f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792401179; x=1793005979; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62oqdDj8dlT0pxuHt5cHb69+lEDkeWcIgt+nbW9frLw=;
 b=qSGX3yyvvvOCr9P+dKW37sZl/C7JkJ1RHo9vIBJp5AZLE5qEkvUGVY5oiCFBb9Lk5d
 w1ZlIeuI2m2YMEBquuxtS8f7fPzOLMweqIq9F9BQhkF2TqJCPtfKHYlAl0Uvw+S8Prlj
 ljvCUYaQr9xS3aCJXTtHd+HsfipfArRda218qOm3VPNntXaHA0oBFDe7Ve4bitMS7k+I
 5M6j1K4oqBM7SfiVc7wyOG/tUE9i1OXuQGSvL2MVnEgzk2F1w3+3CwNGKiNvvO6uYMqK
 gTyAFFQFICdaext/nysAspEL132ZgTnT8uM9DsoGK4MvB9wmqTq0bOdycIbQ62bNTBfm
 o5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401179; x=1793005979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=62oqdDj8dlT0pxuHt5cHb69+lEDkeWcIgt+nbW9frLw=;
 b=Wmnci0ci/nUAxyJ8JJkOrJxVwnvwL1fTUdzkRK34K/ipmwHq/ke2Mgy0n7t6qwlkSd
 tHlpRw7snFRB0RhJy0sn94K5c2imip1hOl3zP/8Kz1eZ84vNbBht8dHiCDpki2nxAS9c
 d+CK052abNZ+ZUGijbO9KAruFTpmZCQPVyWl3jhmOFQSXlrm2nzJu+9Df6Y/L7R4YJa1
 DbVM/PZb+1/Nv4xAoj5BKvu8gPWor8z5r9ey7j2bCqeo5uEpOMlpA3yxv1RfGCMnW3zL
 xjU+qJOqNwjs6dWTjHljt+yHKBmwASCBXv17qyvpcMiJulsumtnwsHg61wfc2cVXBp5o
 X/PA==
X-Gm-Message-State: AFq9FYKjcuTGbiB78Tz1l1cI66ihuGID9jGWZIr/1DmzF3BLSPN3JNwH
 2xUX6nQ2arpIij7sI/2lLS0mNi4jiZ76j0XWcKHYkaiHHg7yUgN6e2N7HMMNYvm24TErJkgBM2o
 dAOBsl2pRD2N9DDtncZvOf4Yhk2zX9yY2EtI0JwFbda1v/eD+BBTwKDk7
X-Gm-Gg: AYBFou34Hr9/DBYUs+qgJyd6GZNIwdMnbXeVeSUK131EF6WTwZPgv4k2dy3obfhzA8m
 gHQUUFtuKC1apEFJvHaArOWx16oxFWhlndoDAoiD8jcINTtOrPMB3OYAXi8DDQ4e+b3JvqdgES/
 egSjWZ8mwrL0Q2nfChYyW1QmZLvONdeE/vMzbHBc5dFOA5RRjPCduQ6hyaQotI6ycnsQsmTsGMO
 fJ2dJhzG3yS2HfL1r2UV6L40YbghCGFXOznJglzOv3J7NNXnk5UonF7LNTtxaX6AMEVfoi2BmjN
 eMzj2mBs94aM7+ZdS3mzqfT2q2vIS8irH62pQKMZb9BSF+Xz7Kvavk497N+OqpVkZJiOpq/dfWq
 hwTbxg8eJnJljEn2Yrt8ZEEv3U7Mq1B3mZ88YjiD1I4u0mwvaVCBmNFrE0O1lX9UpM/J8
X-Received: by 2002:a05:6000:b06:b0:48b:a21:87f7 with SMTP id
 ffacd0b85a97d-48e07f9c0ffmr10859082f8f.44.1792401179007; 
 Mon, 19 Oct 2026 02:12:59 -0700 (PDT)
X-Received: by 2002:a05:6000:b06:b0:48b:a21:87f7 with SMTP id
 ffacd0b85a97d-48e07f9c0ffmr10859034f8f.44.1792401178634; 
 Mon, 19 Oct 2026 02:12:58 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.36.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50ae5esm24137600f8f.51.2026.10.19.02.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:12:58 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 19 Oct 2026 11:12:47 +0200
Subject: [PATCH v3 2/2] docs/system/igvm: document MADT, COMMAND_LINE and
 DEVICE_TREE directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-igvm_command_line-v3-2-29aeacbd6cd7@redhat.com>
References: <20261019-igvm_command_line-v3-0-29aeacbd6cd7@redhat.com>
In-Reply-To: <20261019-igvm_command_line-v3-0-29aeacbd6cd7@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The MADT and DEVICE_TREE directives were added without updating the
list of supported directives. Document them, together with the
COMMAND_LINE directive added in the previous patch.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 docs/system/igvm.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
index 9db8ae43d2..da1e965f54 100644
--- a/docs/system/igvm.rst
+++ b/docs/system/igvm.rst
@@ -72,6 +72,14 @@ SEV-ES, SEV-SNP and non-confidential platforms.
    * - IGVM_VHT_ENVIRONMENT_INFO_PARAMETER
      - The ``memory_is_shared`` parameter is set to 1 in the guest parameter
        page.
+   * - IGVM_VHT_MADT
+     - The parameter area is populated with the ACPI MADT generated by QEMU.
+   * - IGVM_VHT_COMMAND_LINE
+     - The parameter area is populated with the ``cmdline`` property of the
+       ``igvm-cfg`` object, or an empty string if it is not set.
+   * - IGVM_VHT_DEVICE_TREE
+     - The parameter area is populated with the device tree generated by QEMU.
+       Only available when QEMU is built with FDT support.
 
 .. list-table:: Additional SEV, SEV-ES & SEV_SNP Supported Directives
    :widths: 25 75

-- 
2.56.0


