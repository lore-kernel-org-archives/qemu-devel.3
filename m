Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770CEE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXFz-0007PG-Cj; Mon, 09 Dec 2024 01:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKXFn-0007Ln-Nx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:28:24 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKXFm-0002gA-6j
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:28:23 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so1808772b3a.3
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 22:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1733725701; x=1734330501;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=32aRfJiZCyeWujnp9jI07Q4FuOy2EDLgMR0FOmkXLdo=;
 b=f1glfZ8B+VJPAoxyRQTiY3Olpk1gZ0g7HmwwC85pN2Yqt6rIVa9bHQTGay0vUSCh5g
 l5xqIIzxnckU36aKxhkEcRHy/lW3ZJUMUnq4WegdkbJvUBIKyanjI8Bo0HRtCQlxq4Xq
 z8rfNK+/xvufjBSYOeDKq9koAqxIJyPEV/z0xKbbzeQSQzjnmcVgp8BZ9pbP4oB/8iBN
 DAr06wrV85H+tiDbwinUYfb2ZwnILbZ2C2yJ0zswP9V6WfivaByBq4tArSfdfRDpDwDG
 KU5UMmu5gOQ7KvviCvli12RHpz7enF5YnrzzKDcsstOp1tXWXXOuL02vBHTn652F6oGT
 0q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733725701; x=1734330501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=32aRfJiZCyeWujnp9jI07Q4FuOy2EDLgMR0FOmkXLdo=;
 b=VPc9kIIYPRSYsZ6uaO/w8h7FlHOQFzUhKKrQuCIEyRiojM49JeWViLPRhgMU+UKJxf
 6Zhiy857Rg/EH60NNTwS4Zl/iQp3BCArK101XRaG3lP4bNqbY9gJzVQns336HEFyC0E0
 J8cC5xc4eBIT37ENmZ2sPptoELC+7c9EvmjziCr/F0LveJhekDaoWiSf+xV9oMu5ZTdC
 hDtHfyuN4UQ2oc05e4E/gNQdByeCZ+zizmlRjghtpjg7dl/lwXFiA37wQHXHztF39H9D
 wRiannhQTABYBEipbMeSKcQWapUTArz0nEY7uPmaxN51fv1pOfRe0CHHmULUJThuwC4x
 6qHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQO93E/1Z+LpdKy23Tt7M5pJZOME9uZCA1/bvjGr37QfPpg9kutUwtxPooGk9sYTRHR6wqBQ573OH+@nongnu.org
X-Gm-Message-State: AOJu0YyEDqHYt8sPvjum5dbSkHx26NWdJnzPdEG15LWXf86vjNrDJKIn
 bnz5sa0qQaOorUwTWMtJ83uuPOIYJHcMHRrtayYhYQmizPehiMTxF8t1yAOrvNQ=
X-Gm-Gg: ASbGnctJkLpdl2gr9vU7PbporwBQGIv3r0TyEFuan2QljL5qEnD1oYfmcbgB+fC+rSX
 DTHnT+q/U1cjja+Z6+RJSA+wVjk08lMBjI2wzVK/9NL+k6wKvlakx44Rq23FY5Kkpg2cvppU09J
 Z7hqqN9br89QL7aXG+WTwe3FSLD02kcTfEulKstLFuQzlIaZzxVeHLwClflDtNrmo8XVv8S6doc
 x+PMhVAfSts7MCJ1E/7vgXKb20ffuV7hXhQ10i2Mm72LpPfaeOpL6EC4w==
X-Google-Smtp-Source: AGHT+IGPDjc+rv8W9MoYu93+s9zHKV+vf5JFZtfQDSvtBogaosNk43mjI+lpgSWsnYdVBpF2JrTQvQ==
X-Received: by 2002:a05:6a00:368c:b0:725:df1a:288 with SMTP id
 d2e1a72fcca58-725df1a17d2mr8904895b3a.24.1733725700758; 
 Sun, 08 Dec 2024 22:28:20 -0800 (PST)
Received: from [133.11.54.81] ([133.11.54.81])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2cd3829sm6758784b3a.197.2024.12.08.22.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 22:28:20 -0800 (PST)
Message-ID: <48f12a43-c528-435b-b7dd-80d607a708b3@daynix.com>
Date: Mon, 9 Dec 2024 15:28:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/usb/hcd-xhci-pci: Use event ring 0 if mapping
 unsupported.
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com
References: <20241208191646.64857-1-phil@philjordan.eu>
 <20241208191646.64857-4-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241208191646.64857-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove the period from the subject.

On 2024/12/09 4:16, Phil Dennis-Jordan wrote:
> The XHCI specification, section 4.17.1 specifies that "If Interrupter
> Mapping is not supported, the Interrupter Target field shall be
> ignored by the xHC and all Events targeted at Interrupter 0."
> 
> QEMU's XHCI device has so far not specially addressed this case,
> so we add a check to xhci_event() to redirect to event ring and
> interrupt 0 if mapping is disabled.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/usb/hcd-xhci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index d85adaca0dc..5fb140c2382 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -644,6 +644,10 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
>       dma_addr_t erdp;
>       unsigned int dp_idx;
>   
> +    if (xhci->numintrs == 1) {
> +        v = 0;
> +    }
> +
>       if (v >= xhci->numintrs) {
>           DPRINTF("intr nr out of range (%d >= %d)\n", v, xhci->numintrs);
>           return;


