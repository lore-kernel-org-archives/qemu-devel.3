Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E16CD343F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUtF-0002Z0-AC; Tue, 03 Sep 2024 10:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUtD-0002S8-MA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:52:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUtA-00068l-Qx
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:52:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42bfb50e4e6so28792215e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375131; x=1725979931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9N+VMEEXi1hOi8cR4i3iZyxOIBADPozV3ZzCoQMrfYo=;
 b=NgfLyq2n87InmrsxBSLgUUNOgNGJT8HeTVClsAfcREd33TaEtiXdN1n/Tc9k7pTyJ+
 gAauESOUMXjSeqaSN5MuYmvqh9KQlxA8t6I2dJohVLHWMl7pdUjjsF3vzcCiC5EMoYQW
 9p7YgRqeEOpn+oGLNYxL/ZO0T9cSwCx/LbnEyzKwmffY3tQIXOGzu/Ik3SJ6iCBfab2t
 m5XjkOTNfCbKvcZPAwtrS0o2ebHrkZeCpvJs7dC7mnsVvueMeC34sCR17pSDMYzruQQB
 FTE4WdC355XCpL6SlanKlLgCRNmQ+c6LeOF76hxbX1vkqdVMbTlC8Piy1Cmn2GhhXibk
 eDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375131; x=1725979931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9N+VMEEXi1hOi8cR4i3iZyxOIBADPozV3ZzCoQMrfYo=;
 b=NxXNNLAAvPnxxXdaJCybfy6+AnVbfOQkYPjRDx9QsSk/RN6vmihziSkPEcf5o6sDTH
 thWAeUTiLb7On+/1DG7wXk2t/zkQw1PdC/Pv11r01yF5JdiqshJX1wpQA3O3ySa8Ldvk
 Ao2V+mQgChy2148L/1jXTRR/9fpzsA/1hiWxX0ynmoJgap3N+IumpVVhqBNJ2rUtI7Eu
 stg+b5+PCvlhG5+N+y/MxzPjamLYZB570V1NQZenVicO2reclKYt3GeGEhGqnx6RJQ/q
 aIJBMoD9SPpdwjthr8rqOqB72FV1bcFFlKoT6P/XdL+H+yXPN3Nu1GWVUo2Vnj0cIOdk
 SHNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzxlqwKUsgx4dlQaOPL1azi4hUY5TMqx1SgEUwbp76XFgFjdoyfqqohda+hgqkbYWXLNywQJ0A/Ya2@nongnu.org
X-Gm-Message-State: AOJu0YwZ6K1xn+Dkic4S7DpY9VcWgl1Ox+QKeZb5yznXkGY8JP5bj0JG
 ov2XAflZoSLXecu2eatZgHKJhqLQNXBRW1Vkx7tBYneoDX4d8kmOvd5CyNNOFNo=
X-Google-Smtp-Source: AGHT+IFrzFFKzbDmCXZpwvOGSUF/IEBrtC40AW7GTPuhJ0ZjZicMYjk8BRK0DxFY76bfPo9KDc7boQ==
X-Received: by 2002:a5d:64c4:0:b0:374:ba34:d2fb with SMTP id
 ffacd0b85a97d-374ba34d390mr8145444f8f.27.1725375131144; 
 Tue, 03 Sep 2024 07:52:11 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm11358572f8f.103.2024.09.03.07.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 07:52:10 -0700 (PDT)
Message-ID: <a975d672-d1aa-4a7d-96a9-763cc2dc5b85@linaro.org>
Date: Tue, 3 Sep 2024 16:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] hw/core/resettable: Remove transitional_function
 machinery
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
 <20240830145812.1967042-12-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830145812.1967042-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/8/24 16:58, Peter Maydell wrote:
> We used to need the transitional_function machinery to handle bus
> classes and device classes which still used their legacy reset
> handling.  We have now converted all bus classes to three phase
> reset, and simplified the device class legacy reset so it is just an
> adapting wrapper function around registration of a hold phase method.
> There are therefore no more users of the transitional_function
> machinery and we can remove it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/resettable.h | 13 -------------
>   hw/core/resettable.c    | 24 +++---------------------
>   2 files changed, 3 insertions(+), 34 deletions(-)


> @@ -171,12 +157,8 @@ static void resettable_phase_hold(Object *obj, void *opaque, ResetType type)
>       /* exec hold phase */
>       if (s->hold_phase_pending) {
>           s->hold_phase_pending = false;
> -        ResettableTrFunction tr_func = resettable_get_tr_func(rc, obj);
>           trace_resettable_phase_hold_exec(obj, obj_typename, !!rc->phases.hold);
> -        if (tr_func) {
> -            trace_resettable_transitional_function(obj, obj_typename);

Squashing:

-- >8 --
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 2cf085ac66..5cf89da51d 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -22,3 +22,2 @@ resettable_phase_exit_exec(void *obj, const char 
*objtype, int has_method) "obj=
  resettable_phase_exit_end(void *obj, const char *objtype, unsigned 
count) "obj=%p(%s) count=%d"
-resettable_transitional_function(void *obj, const char *objtype) 
"obj=%p(%s)"
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Nice cleanup.

