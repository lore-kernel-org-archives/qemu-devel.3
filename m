Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B0BCCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6W1-0002Ek-AY; Sun, 09 Nov 2025 09:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vz-0002DN-5a
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vx-0001oU-QK
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wDQZ8/ZctjW7C+aZiLH0Gm46nUdO5UqyAPKuxlKrxtg=;
 b=EvgYQxDqg3bZ1GqmjHz6vOmYhjphvyFju7nn4/NRP/AJbk4/pkFzgnkpfWebGOmEFKsSB8
 7k1IB3oSrXRwNKhTbUjivOXaFSeWNgbzN584nO2AjFpXjDC+ZEKJmjA3jXebKJqGHbi/Cw
 jyLQW5o1SWisOHOPfbeJ3i6i7vtsX/o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-C5uNchdJO_6e3439a1NRjg-1; Sun, 09 Nov 2025 09:35:31 -0500
X-MC-Unique: C5uNchdJO_6e3439a1NRjg-1
X-Mimecast-MFC-AGG-ID: C5uNchdJO_6e3439a1NRjg_1762698931
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4777b03b90fso1446355e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698930; x=1763303730; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wDQZ8/ZctjW7C+aZiLH0Gm46nUdO5UqyAPKuxlKrxtg=;
 b=ZyTOnGXaf/DSEK6woUfIAGsZ4XbclyufKiDMDp5ucA4drhMM/1QEzjVbmKJ62KOFSG
 8w1Wiw05hw5LDYCN8E1PZQrdwoSLd9KRe0xOzWeZ37HN8CF0wft43pP2dvPzenSmLHHm
 IrnZEqDVm0ZBKyOGfYAHVqiPEyJYpyECwvjSmqN259uSSy2OqYR/PXmdA0VHE335BtHr
 fXX2JCTw27dxoiF8tcoL9bC5v4+Cnuk1W09Knmh+QL2u9krT5+myU8+ZC5qzT/Sj7xn7
 f08QPuDau00CBu8IwpAd8FJdm0EV6+PYZXHS9u6KGblggQz2Pl7k7O7F/WWcl5ZtV8le
 l4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698930; x=1763303730;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wDQZ8/ZctjW7C+aZiLH0Gm46nUdO5UqyAPKuxlKrxtg=;
 b=PtdmEFnKY4fSYcFHzpRqq83/aMbsyzWpscVV9eQL9vWP9Hy+P5gce8ihFE/79DOJXC
 NtY2gYj2ADB3NcdfmSglZRo/01gu2gtmQPcHcmr9oPSaRfTkrkZv9Dmr00jJbjp4d2jO
 WeI/XiQSZQKCPuz+epI8A2P+7VuP/uoQogghxS5nbDPnez9UdP64fxW82hHpVq3tkaXF
 mG/10PtfIFhT1T5qRfraQGxlNy1aYxI6vfJuoIq/d+239Nx7BAXhQD9HOV3fK04t12Ef
 K2Ya63bfdJSZ9WpO1+hm+Di0UEfKCPmQfRxNJTVbN0MFUC6geCmHnNVtziXyObxbicon
 TiBQ==
X-Gm-Message-State: AOJu0Yzw/c7nODXGCpoC6NjSFYldn5t24BPFbkvk9KxJUQuZP2FXG6/J
 20t4M/unwgwEdJknTAArKmoGc5ywMeaVSer+Up2By83aSZaxfq0Rp+hUlK04V2HMFv3Chflmoq4
 Yk2lYAQI6otJFytgc0Rc91AdfAfc4jcqVCRfgp2PANvkF3ufwNyCoPfugijCrb8YYMW/D2KmUEn
 Q/9YvNeZ5TJEmfFIw412spK3MtU9sNtMBDTg==
X-Gm-Gg: ASbGnctF6iN6HHvKwWszPgGeCXdN74OnlwcbMgUhraaCCdvXh/BUnTmJ/nUXtLySGkx
 oz1oOdrmvkPpAVkLmrmzcfqxIaSX01vkcHsAas2Tn+KgQYVhRC2oAAUGv2fjcisamzvYBhExB07
 KVEUobg7EXxhvfLfYy2d9Qd+b2/XtF5ipKaC/g0tmuU2clfwCeHJEqnMCQEjKrS9mMI1AeJjAJ8
 ZtyMojHculQQ5XrAhbSarkX9qVPjoSNYWf/at5oa3JQ5359uONS9HDt32ZlnTNVHa+i51frafml
 4Tx8sCkClTalGdHh6ogilzxT6mX3MeRNyHgFCb4n3EmxOTVH+5kyjOWA3rdDXKy/QtA=
X-Received: by 2002:a05:600c:4583:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47773229f38mr37995565e9.3.1762698930185; 
 Sun, 09 Nov 2025 06:35:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYEchCI9I3AjX399478DwBenJprOjh5JRZkwcWbSaLXhNNHV4NNokF1arMA49X7j/0e2rEYA==
X-Received: by 2002:a05:600c:4583:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47773229f38mr37995265e9.3.1762698929705; 
 Sun, 09 Nov 2025 06:35:29 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477773f7749sm69323585e9.7.2025.11.09.06.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:29 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 09/14] tests/qtest/bios-tables-test: Prepare for _DSM change
 in the DSDT table
Message-ID: <3e6ad83f209ea8cf497e5d160e44c1bc5e518f1a.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shameer Kolothum <skolothumtho@nvidia.com>

Subsequent patch will fix the GPEX _DSM method. Add the affected DSDT blobs
to allowed-diff list for bios-table tests.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251022080639.243965-2-skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..e2fce2e972 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,17 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
+"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
+"tests/data/acpi/aarch64/virt/DSDT.viot",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
+"tests/data/acpi/riscv64/virt/DSDT",
+"tests/data/acpi/loongarch64/virt/DSDT",
+"tests/data/acpi/loongarch64/virt/DSDT.topology",
+"tests/data/acpi/loongarch64/virt/DSDT.numamem",
+"tests/data/acpi/loongarch64/virt/DSDT.memhp",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
MST


