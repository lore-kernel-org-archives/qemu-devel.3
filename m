Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDA3C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDjm-0002mT-KX; Mon, 13 Jul 2026 06:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDji-0002lk-P1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:18:06 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDjf-0007hr-Sf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:18:05 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6626b5ace23so5809107d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783937883; cv=none;
 d=google.com; s=arc-20260327;
 b=FF195Mu7wLEsR9rok7jB6ynooBC/8tKKDIz7gyvlJskqQV31PRpBUazdmOXunz6K2A
 zQZkekvNPucB6sK4+COxrjyJe4tmZXB5gziKP099O78u8bRKvdj/QNnmEisAzhjZLVrG
 pdQP/fDu3iki7ktbxHYBmtkGllsRxmP1gTvaURXR8u8336jQrAljb5QD94xu/q5gUUcw
 yPB7nfdGr1yXgB4olha/eLVEemQPMKbIB89NuH/alOHG0NLeQrOfv8es5LVwK4RETGd0
 OX3M/CIHe/zxte6c9vCNsCcvG+b1t0qLgYw9qJ7fYmolc5P2kKRbCaf5kxK5jGDuLAgA
 kYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bjCwi4kyQywSiEC5ILPY3B6gCFupp4Tt8f85lXOyU0g=;
 fh=Qa2OkYOPFog+x1G5mA4V31494fitPWoGQxwY2RYXA+M=;
 b=EDqYE6DIhmyxbIoT0nRncKhgJwJ8qjdrcpfJNmETEQPlvrlnVxnWeYWTfLH0l78zcD
 YR6eZVkfJx73mA2glmanjLIcYVEt86A2/3fKXk6z26WXi5Ald2zr9nzsHXkxKdfL++GC
 8eA77Loxyn/cww/lpFFwUurH4VoViwANWoixTWy8WxNWKyu5UdqiIVqYnvrVrTNK9VNo
 3NxmXrT3zETWVK7n09HgqWwh+ZzH6JbI+KfVYNVoM61OGwFZcIGE1CjsCOqg2p77uG2C
 g9hmSKMp3616uRKC8atAUOMdjBoshQ8aiaaAIoTdybHgdAjNKgtV+cupJ6tAxUJ0spJF
 v3jw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783937883; x=1784542683; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bjCwi4kyQywSiEC5ILPY3B6gCFupp4Tt8f85lXOyU0g=;
 b=coMdSLlNmNuvm9aeE+H7qq+/2/COZcKSFqElKEZzFxaslEx1cBeL94wFHu2Sm3xbEN
 S6OM/jxmOSlg6/6PAxgJA6YZ1qSIH24wW9WDwLtxqQbqPsxOygd1gGl8xcDGd4rxSpNM
 9NOD6GJlvGCvp947Bwio3yoP1ri/u/RYGeOJ5lLdtYPze90h0/4GFoPqWuFjTqLRiDDf
 mtnO8mQylkSrrSkbE24MlF22Mj6ToSB5olY/rJ11zAicFyeNTG4D2GSTIK9sQ0Gt8NkJ
 p3DlNlHLtfYdx3euvBRFrVXYKQVAP99f0YchY9ypc5K7JL3XkYdt4MrxDvvcbWQCw3Kn
 6VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783937883; x=1784542683;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bjCwi4kyQywSiEC5ILPY3B6gCFupp4Tt8f85lXOyU0g=;
 b=YzsIp7F5x/LrCnBjVeFc/zxZGempkCASieST9SKNHeojAtv2LviWDTTaADVU1I3MPe
 +4tWnOeWEDq0RGTH0TIGy7kYXGK5naTcwc9PBTe39ZROU+1Iq1Fxyt8ifzIKRezrByNZ
 /ruIsbo/yqhn0EHVWEIJpc054pHdqFYkfnLVCt6Ap11Mm3MqlHnI9UX797lTPTv6EQOH
 nWfiv8XIWNCO9Wn+SiQiXIerqy+Nz+iiKytUlvt+C3bGSJk2EXz0C/uB8yzlpCzP5lwS
 BtdzULRSz+KjTJzvyMEWAvTA+Nm0fd9UloVJOwMK/89h8N2+FtRvGJqItjV2MvKyqZKd
 kUfQ==
X-Gm-Message-State: AOJu0Yyx0IIOI3tImER4kT5rGUT4b6qJVxior0jlD3T/y8Cf70Mv695H
 vWLE6dtcqTyXIXeT82jAhQldKXYBWCy+r1VoTPIahQUp3QX9KjICbemD9PvvMPOfoQEPHDdXO0o
 2PT2RRZz+bxvk34qKz9/IkBzzp+d7LzCGQYyUh9WB6A==
X-Gm-Gg: AfdE7clCL0mmHWB5Y9vSl2pZhEMBCnl7dpSTp0pFK+nXSSwcwtJxKY3SiWcLO+NcoY/
 YS6R0z8pjjdzc+qRPLv+CNGS40s8+QpQCcBZM/Wk3qyLbnLilLZuwCAeYsuH2PoPGX9u6VGwp5E
 gSH8YpKHpk7gngdVFK+p6Mti6UnurRF1aNq/lv0UKN1N2yZoHXqiLj1s8mAxRr/0o5ffxuG8TE+
 NPQEWOhmKX5df+oFP4csn0QGi+IPQe1GG7b9je+bcA0g42B54n71wtTmvzMXMH96bXi1bqgN3bz
 oQgGZVHMaYLGO27SzPsKg/QG4u4ighN7SN7WhRfV+CQsUbZskcSEZVJpVKjUHlxoKg8=
X-Received: by 2002:a05:690e:1918:b0:664:b3c0:653e with SMTP id
 956f58d0204a3-667d98ec083mr5163887d50.29.1783937882619; Mon, 13 Jul 2026
 03:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260713100508.123623-1-thuth@redhat.com>
 <20260713100508.123623-4-thuth@redhat.com>
In-Reply-To: <20260713100508.123623-4-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 11:17:51 +0100
X-Gm-Features: AVVi8Ce9GmRshp3IUMcZ1Y13AORWJqj1xe1dCEhzz3DZOTynbYlV5S12XSAOhy0
Message-ID: <CAFEAcA8=_3Ofp3KnOXgfk6OSRHZtvSF6L2pb47XfC8b5TTZo+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/usb/hcd-xhci: Use qemu_log_mask() instead of
 fprintf() statement
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 13 Jul 2026 at 11:05, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> We've got a proper way for logging unimplemented hardware features,
> so use qemu_log_mask() instead of the fprintf() here now.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ee913d5c4d5..527910d92d2 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1017,7 +1017,8 @@ static XHCIStreamContext *xhci_find_stream(XHCIEPContext *epctx,
>          }
>          sctx = epctx->pstreams + streamid;
>      } else {
> -        fprintf(stderr, "xhci: FIXME: secondary streams not implemented yet");
> +        qemu_log_mask(LOG_UNIMP,
> +                      "xhci: secondary streams not implemented yet");
>          *cc_error = CC_INVALID_STREAM_TYPE_ERROR;
>          return NULL;
>      }

qemu_log_mask() strings need a trailing "\n" (as of course does
printing messages to stderr :-)).

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

