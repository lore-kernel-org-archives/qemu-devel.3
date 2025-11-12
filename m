Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD12CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4tG-0003xa-4x; Wed, 12 Nov 2025 02:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ4tE-0003wi-5y
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:03:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ4tB-0003yF-VO
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:03:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so3406565e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 23:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762931010; x=1763535810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q7se5OtenhZotDJ001wyYbB8b+98LBInT6cl3Lx8+Tg=;
 b=d212h2RsQsx+Y1EfnOWZG/ZCssISmuNwcxp//l3H+5vIpscgkKhJ1mu8UKVihiF4li
 65790LIQR3xu5qj9TxX1KyJaS91ZEQ0CchLlPeoOaIP5fjgExPKzjkj6ivo3UXx4xMbA
 frGNVnZqYrWqjs9Dtu8xD2jlLYcjBYm8lJO6prCgCASaX72JB+0MbaCMWQo3/9QEdDwq
 dsYBDjS/mI7NL3lH9BUhWB/jWf8HMLx0//qhdNQ5LuphXE3cBYBWpvO/+lMCSNnHb6im
 u+mE+7zXUYkxFsRzSejIm0blrLz3p8raAGcR/I5XaFGE0lXrnHScfLYVzIxB7Cbe0rZE
 AqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762931010; x=1763535810;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7se5OtenhZotDJ001wyYbB8b+98LBInT6cl3Lx8+Tg=;
 b=NZ9AG39fwO9BPzVLmVj/DKpnrgjMIrauhO9Ghq2bI/cAwSv1g0BWK6U2ICKpZM9jE3
 a2z2xqm/cWBwYRU3+jYRkQN2448OWt98yy042HVGqHHZjo40Zp0TlXGZ3dQiGLCLjjjw
 RXnc8fMq/cCGhh0QiUPS+krvAPCx4RuhMqwF4QRNdDWFCZ80Lrviww065bf0cyYJpsT2
 AWSSxpQDGLp2GcZ31yTwHYb/q+JDUnkshTjVxufPhpYiyhUqUqaRbF2E3FL02SiiWNV5
 +KsrBRBTuIZ3iDH6VpcodoPD0zmQ2by6DOIRwU76SQ4r7lUii8yZoyvkY4LS1prZNd0j
 vDSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcTOpU6uexp0SWaTo5FA5zbZ+ifx7FIMOQG/X9JURzTqgxngNJOkv5tzeju1w0cnHgqdo0v8u4I8ep@nongnu.org
X-Gm-Message-State: AOJu0YxpDQOr7BdN/+JvCvfJJ+cAJyUAGlIc4rBiYIDqZrIhsmaRqRkc
 RxP3JdqvJrWdRfm+zIZMc5wYrrF+gOoGZHffrywEhhx249VNiFugTGY0C3jwK9HR1lt2uo4nJnU
 86zfBHC9JXA==
X-Gm-Gg: ASbGncvJA92h7htn92GAAJ/H0iTInOmoN614IB+dCEEaene5CTceQCvNq59n0LQg1H9
 ROULibUa1M7J+BtrYxW4PNzh9qf5YjTH930iMrL5dGu1s/t8UWMJuQXuLPeitY2tNRki/v+0szK
 SHixPFEddr5daYfpzrjmXuSWXSrmYixP9w/Rz3cpzWqG/S1l/KN4gkKhmGB1pnAM43XJRO5Wejc
 lTj73o1ET8cQNo07xT/xf+bkk9b//GEZXPb5q5/tuUQ4xcwzpoKsq1yEKtIU0VLAkEX2n1eUc2C
 Y3BUjEAUb539BzCQNo86kZzrVriJs39+UyuyEod/Q5/JmAz3if644k+evu88IQanaYi2RCQGdkk
 53xwBw10SrdiIh1lPu66lUNsPYCHtLK1UWXiuyAr+ivXrfPUUpmuuKeQ6nB0cNsAMK6wJ8a+fjp
 b+1AD1jpXVAbqZ3lpWS4aq0BayR9QF0813IQg1oZ33REPt2xXv
X-Google-Smtp-Source: AGHT+IHOnc63B0U1gOl3r9X4JbGL3s6/x90m9OhMtpDc4C+jkEoyWMz5L37RY4AzfcOU6+/rrMjG9Q==
X-Received: by 2002:a05:600c:4593:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-477870b2cecmr15852275e9.29.1762931009836; 
 Tue, 11 Nov 2025 23:03:29 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47788a1f823sm6363875e9.2.2025.11.11.23.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 23:03:29 -0800 (PST)
Message-ID: <dfbdc47a-6e70-44d6-8e87-eddf5363ff77@linaro.org>
Date: Wed, 12 Nov 2025 08:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/9pfs: Drop unused print_sg helper
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 qemu_oss@crudebyte.com, groug@kaod.org
References: <20251110155424.694664-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110155424.694664-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Osama,

On 10/11/25 16:54, Osama Abdelkader wrote:
> Remove the print_sg() debug helper and its always-disabled call sites
> in v9fs_read() and v9fs_write(). The function was only reachable via
> if (0) blocks, so it has been dead code for a long time.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/9pfs/9p.c | 20 --------------------
>   1 file changed, 20 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index bc4a016ee3..a8de894f4c 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1389,20 +1389,6 @@ static int stat_to_v9stat_dotl(V9fsPDU *pdu, const struct stat *stbuf,
>       return stat_to_qid(pdu, stbuf, &v9lstat->qid);
>   }
>   
> -static void print_sg(struct iovec *sg, int cnt)
> -{
> -    int i;
> -
> -    printf("sg[%d]: {", cnt);
> -    for (i = 0; i < cnt; i++) {
> -        if (i) {
> -            printf(", ");
> -        }
> -        printf("(%p, %zd)", sg[i].iov_base, sg[i].iov_len);
> -    }
> -    printf("}\n");
> -}
> -
>   /* Will call this only for path name based fid */
>   static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
>   {
> @@ -2468,9 +2454,6 @@ static void coroutine_fn v9fs_read(void *opaque)
>           do {
>               qemu_iovec_reset(&qiov);
>               qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.size - count);
> -            if (0) {
> -                print_sg(qiov.iov, qiov.niov);

Alternatively, consider converting to trace event so we can keep
dumping the entries, but select that at runtime (see for conversion
example commit 4847c5701a3 "hw/rtc/mc146818rtc: Convert CMOS_DPRINTF
into trace events").
> -            }

Regards,

Phil.

