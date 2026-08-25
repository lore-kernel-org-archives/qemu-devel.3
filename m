Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964AFC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp2y-0007IG-H7; Tue, 25 Aug 2026 07:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wyp2w-0007Fv-97
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wyp2u-0006LO-JX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787656223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyhpfySDlDbG+SLnWXyfrNennDDnf1VLf0LhQ9FWX5U=;
 b=bKaCMIvLj5Vloy2xIY9TbMJMk86i40k8MEartTZuByBJ5xx0UeOE0C/u5IBcAcdoRvIDI3
 CAHAGiyuj1gXmZLjCHLK4Y3yU91doV0jKA+ywVTRtzeG5VzV+MS3VcsBBd1FTRb7J43UAX
 f+wMFa9QJHIlsh+FJDgk2yCmCgwbU94=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329--JopfL8VPleORgGI0uZwww-1; Tue, 25 Aug 2026 07:10:21 -0400
X-MC-Unique: -JopfL8VPleORgGI0uZwww-1
X-Mimecast-MFC-AGG-ID: -JopfL8VPleORgGI0uZwww_1787656221
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c160b9c0676so344091366b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787656220; x=1788261020; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jyhpfySDlDbG+SLnWXyfrNennDDnf1VLf0LhQ9FWX5U=;
 b=Q4xoTxSvzi7CV0uvdiEC2r7rlok1ZB8/kEB/AQ0nE3iwk32wFIqTJMNYvugfO9EX+r
 IKWdWMPVf/euDv43MkIFHcVO26ZxTfPBh54oBkOI3A1cxzEbSCmKIZ1/yNMKfBlCuPAI
 TZtTmp3Nx3kbyS3agp3vlJ1nKRGbb1Voq3r7+xg2dzMJmpz3Tofhg2ZxAR6CtzupiM5k
 U21eklVKOEUW2Aip2YoGsW9c0imUWsWjxc7BbpGcdkhOocwKG5w42XNaGKDpUchhsaQO
 OaBKLpvh3mIplGYZlJ0wVZmf2Iu04t/u912h1wHkwzw7M+r20S6KhBbLeAoS7uswspQV
 qcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787656220; x=1788261020;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jyhpfySDlDbG+SLnWXyfrNennDDnf1VLf0LhQ9FWX5U=;
 b=GrmtzJ4yQUBsjFs2WjC5Z1MhVqlxMPsMm57P2afiExelhjNee5bN9oDiwNocWLPXHD
 cB9paERML0uMx/H5RtOZALFfzHMY3vDMlD1MEO2m02TgfzgPYBqrfZVGEGIThtzezuQl
 J770NBAJeoao7IqXsCQDgaAgjZZ/11AR2LKP552JFzheoPZTLq68SPW/O62B2WusSuhA
 QiSbk+hPTwhxih3qeeSBxDVLgj/SOjlK+C34W1RQP/C88H0zxJUw1Lby3LZNZMPsA1xj
 JxJUF6NJdKtb6jgEvubdKzK2TCKqjQdMdYhbCXBQxY+TLbCA9nhpxpo56Nj//ywKQ+bJ
 /dzA==
X-Gm-Message-State: AFuF++mQDR8Rdqk4/OH/s6WqAd8iyXhWNXbv8x0+ixGSHSxiEpSNVbqu
 Df3i766qZRVkDeLAhVNmAfXYc2oc3PH5JFa2FtANs+mgjQwMfOr4fmuX7q6mQRl50FQD5KUZefe
 jWvbcvOHo99vt+c65d2eNE6b1W+8n6crmypw7QZmQHdbCrAXWxHjXq5KW
X-Gm-Gg: AR+sD10rFgQo8C6rndPvoiHgMooPRcVA5lfughCMZ9f+UWJunoTM70OO8w94Tr/KLeA
 cMbnRc+6vJgyBRyTN6tFsyPoUR3Ule+GJw+NBxKpzDdn0N3VSd5iFQmZ43a6ohe5IdiPgGtQzC9
 Md1+SAiww+qjBHtkr8GSXYSQp+pBl7UZPvxaTbz1p5ZZENnyJ2zCdrmDEF7PqmoRsLzpyu8YjNt
 4s/TszPShJ/d3ZlqzCGOr5M44ilXqD/kllDB6DjnHFQzBYeF/WNNHsdQXOLMd9E3/y35UHSes8i
 VSgBY2zPpqzoIKVuvCseNf8XLT3VIOCHrrJEwG0FtVt3zwlAlPlAi7rqeQYW0//3oTOCQ08LNC9
 Y9afyAsIGbMFXZ6J5UxKPg34KzM84sCvDlEG+awmGxWRWVqn1+vrVT92ckhQnTkYUhEt4QuXV
X-Received: by 2002:a17:906:8d8b:b0:c20:f913:9337 with SMTP id
 a640c23a62f3a-c24e5bf20bamr659604966b.20.1787656220652; 
 Tue, 25 Aug 2026 04:10:20 -0700 (PDT)
X-Received: by 2002:a17:906:8d8b:b0:c20:f913:9337 with SMTP id
 a640c23a62f3a-c24e5bf20bamr659599466b.20.1787656220193; 
 Tue, 25 Aug 2026 04:10:20 -0700 (PDT)
Received: from leonardi-redhat (host-87-7-3-68.retail.telecomitalia.it.
 [87.7.3.68]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249629a901sm1877440266b.25.2026.08.25.04.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 04:10:19 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:10:17 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: Re: [PATCH] hw/misc: fix trace-events
Message-ID: <ao14AbYCgMoH1APm@leonardi-redhat>
References: <20260825074114.853069-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825074114.853069-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
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

On Tue, Aug 25, 2026 at 11:41:14AM +0400, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>The commit 8041d1730871 accidentally removed the vmlaunchupdate.c
>trace events.
>
>Fixes: 8041d1730871 ("tests/qtest: add test for K230 gsdma")
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> hw/misc/trace-events | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>index 16db4ba0cc17..0b8be3d0f226 100644
>--- a/hw/misc/trace-events
>+++ b/hw/misc/trace-events
>@@ -446,3 +446,9 @@ iommu_testdev_dma_armed(bool armed) "armed=%d"
> # k230_decomp_gzip.c
> k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
> k230_decomp_gzip_write(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
>+
>+# vmlaunchupdate.c
>+launch_update_write(void) ""
>+vmlaunch_reset_enter(void) ""
>+vm_launchupdate_finalize(void) ""
>+restore_host_x86_igvm(void) ""
>-- 
>2.55.0.543.g5ebe2ebe4ea8
>
>

Thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


