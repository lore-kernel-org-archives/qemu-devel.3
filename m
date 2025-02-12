Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E90C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEZ1-0003zx-I1; Wed, 12 Feb 2025 10:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiEYy-0003zP-2M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiEYv-0000fk-LP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739373721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dGQ286O7H3JmJgdgn18YZXFlM91V7c02EXBJaro/lY=;
 b=UjOKfgmhDYS32cIpzvEA/eE84qWNMHDK1oZBFdK9OF3gh+w7gWf3J/8fJ555YhOwu2FraC
 gLLWfxQaBwWSM4NPkIFC++LFJ7qtNN89qJq+Mv8m+PxHbXKR3cmQjWyGEf/piUVtjhWFQn
 nNTpZsTDn1PSVtL5S/BcmienDB0CMFs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-WlHv_jTOPMu8--xzof-SvA-1; Wed, 12 Feb 2025 10:22:00 -0500
X-MC-Unique: WlHv_jTOPMu8--xzof-SvA-1
X-Mimecast-MFC-AGG-ID: WlHv_jTOPMu8--xzof-SvA
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-471ba1f5b25so15299171cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739373720; x=1739978520;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+dGQ286O7H3JmJgdgn18YZXFlM91V7c02EXBJaro/lY=;
 b=B9oTveQn7Uo0vMiYpoH27w/83AHxM3DD1WalSB1abBtxoBBWX5efCzOuwtCjIeiAVg
 Wryu9T6AlPMPlu8ywz5stiGrxoDAnsqOPr7VGnMVZRhERf2Wrl1HnXc55wJIwdZXeODr
 h+dpoQoeHl1PA9qcJjPDnqp4zawj+BPEqBAUOJ4TJLWvQ6Gtevc1AIxmFGUSebNiPnjO
 NNaxezePTJV527X0Ka+EXCZ8chC2xh8z+gdI8UDVq2x71tbDr2YuaF53OlAoOj8Y3af+
 AhJaSNQdE6Y5YTRG8gH/sKKI1tkS8GM2uqKlTr86XfxJT3Q5SR4hm49qzP1lM0wlfiF5
 hzNg==
X-Gm-Message-State: AOJu0YwXyUSztEtSSGe8cMXPz8O0yC3Hdhcq4OHC6dp5mqZPK/IvMgvG
 v/Q8NLMBkVdxzet78qzDa+CngDoKxu9M8sha0b/oT3zzm6ZgntoKM/wr6BUv4qEyglGvC+YhKBE
 B1Ogq95L73jR/aZhFzo9RrPmEp+iQejSqKNciBIArCFQ82oox7gC2
X-Gm-Gg: ASbGncvQ6ZUhsfT9p2zpP4H5V5FWJY3MPXxP9N1AAfnrkI7rRcaEVOt655+2Vnl1lrr
 uC3No+Jj8LdAUJ1H3l1ReST6/laCMYySMoxd1mg+kSjZg9mVAMuJ8W3fdna1PchIk48ROx2cxeU
 5uk8j2+1R+UfxrNIZ3WQJDJiE9TYeZWbUmkm6UZnatQ+cRtYYgv+bAyEnx9BkKpumNWZkKvZdd5
 7AQ52j1d9QTV/s9H+EXWBblehEZI94tqNNAgvaS1A0BeKWi0WBBTfe9t8Q=
X-Received: by 2002:a05:622a:6988:b0:471:b10c:1239 with SMTP id
 d75a77b69052e-471b10c16fbmr37919521cf.38.1739373719767; 
 Wed, 12 Feb 2025 07:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvlPihoKWEI15dYv2ndQfT+UADfaQ2v8Lp+e4WtXaFnC6E4gkQtJZ/MVyAzZKYZh/84SWzUw==
X-Received: by 2002:a05:622a:6988:b0:471:b10c:1239 with SMTP id
 d75a77b69052e-471b10c16fbmr37919291cf.38.1739373719466; 
 Wed, 12 Feb 2025 07:21:59 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471995e41casm35635311cf.64.2025.02.12.07.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 07:21:58 -0800 (PST)
Date: Wed, 12 Feb 2025 10:21:56 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: Re: [PATCH v3 5/7] memory: pass MemTxAttrs to
 memory_access_is_direct()
Message-ID: <Z6y8lHluUzIt75Tg@x1.local>
References: <20250210084648.33798-1-david@redhat.com>
 <20250210084648.33798-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210084648.33798-6-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 10, 2025 at 09:46:46AM +0100, David Hildenbrand wrote:
> We want to pass another flag that will be stored in MemTxAttrs. So pass
> MemTxAttrs directly.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/core/loader.c          |  2 +-
>  hw/remote/vfio-user-obj.c |  2 +-
>  include/exec/memory.h     |  5 +++--
>  system/memory_ldst.c.inc  | 18 +++++++++---------
>  system/physmem.c          | 12 ++++++------
>  5 files changed, 20 insertions(+), 19 deletions(-)

This breaks mac builds.. I'll squash:

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index aa1455b629..1554f3b801 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -137,7 +137,8 @@ static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
                                          MEMTXATTRS_UNSPECIFIED);
 
     if (!ram_region || ram_region_length < length ||
-        !memory_access_is_direct(ram_region, !read_only)) {
+        !memory_access_is_direct(ram_region, !read_only,
+                                MEMTXATTRS_UNSPECIFIED)) {
         return NULL;
     }

-- 
Peter Xu


