Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8961CC54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 20:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro8NS-0000sr-EH; Sat, 23 Mar 2024 16:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1ro8NQ-0000sX-Mu
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 16:54:04 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1ro8NO-0002D1-Hm
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 16:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711227236; x=1711832036; i=deller@gmx.de;
 bh=f2WnAskoAAbOgAYTkRzfB7sAgl5wrNMEHCj1VY72lro=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=mYW62u1W84RrgGQcDGB+yfi3/XSOWKNsI8NiwDTYzsKkWJCvOUpeGoQqQoveDIak
 hqB/xS2o+5hLuj++FciU0rpSO9W7P1iI0k0T/GwWRxtPpE7I4YzLGrY6E29l6vPG0
 DB0FpZpQW0uRAsBddoopZeb7FaWanwQ1ajerXBrw5kCreS3ZmNCWo2y7ICd8ggCFx
 SZ+Zr5uPoZv/qpBDzl0M1t2Aup+sD+WkmAW7KXcoaCirTUHxf+FUCT6+x14zYBYYf
 F6Io3SC76K5OoppvINRt0cimcxCSbtaTxTtzbRLsmfyZGOjOZn4kimoIawsgfppRh
 rKI1nqGtpsXqBPMZTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.187.196]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1qtIOh1oT9-00v9kn; Sat, 23
 Mar 2024 21:53:56 +0100
Message-ID: <99304ad6-32f8-4f91-afb7-50a916aa8e78@gmx.de>
Date: Sat, 23 Mar 2024 21:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] target/hppa: Fix BE,L set of sr0
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
 <20240323172954.1041480-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240323172954.1041480-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qLAs6zqkcbvdcbDKV+TURKzbOV+E2BFC8pXfySVY9uDfloDxZYL
 nw1nWXtP5FwmlZC5PlwLVrDw5YpC0uOaFULE4VAVpE3/jJZ3S/XJsxED6X3gimhRlTVzoSF
 CXL5G4cVnktfo/0pG7ylqq2kgPbJF1MQZ9mBXgQU1b4i8bJNn0gkSE4wtldH8QnUWGtafWz
 xkzDAw3b0OsAHSxhGjw3Q==
UI-OutboundReport: notjunk:1;M01:P0:CvuJarycDfk=;Jki5pCi7bcvMh3gs7cqBqhniBKM
 +GH7FEEJBnAjaCW8YThCfQxSoCE8CSlVTg+WLKLleF1OyoN5AQySN32+UgetkD756WQl2jAVM
 f0S/LrEPIgSS7jFK0Vt9H11+U/Oo+gxN+nArg5GerYWVnFak4j3fzbu7kZjp9Iu/cdQ8Ewxlz
 Xc0/eXhAzBs133ONWQDV/Rbi1ioUOQ8mRdkTz5Uff7ruJvygX5w3EPLdbiN2rqDNyN9InXXaE
 vwy9lLEth4Baeb1hElcXYNfqYhVF0mNNIWD+ZUoE5MH5INb6IrEuyrH7i4Rslv9P9KMl7Sr8q
 LAKx4ourPYUln1cIWuIiF5k6GKYvsvghdStMSsnMAmHTMyf5m4olB50OVyF4Q6kxeHegkpn8t
 ome+Se5UNvvwSay9TXOuDNrp7z2rN9YasL5eMYhQuRdfjZD1i8Dh+e4nf1003c/Ac1a0rh+L7
 qI0MCd3XVWLdv29IhVXhPqVW9VfiN3Wla5PGQhg31qVXsRNhcfCulNP1qkJwAXfFsbk6uVyGk
 TxrtojPqi+pkT3z5c8AgFPriEdkzxpAWAp4KZk/0RwEqnrj17XpNwkoSC1MNznpc6+IGsT9R5
 do9nhyQCsaSOiYs7ekTmMwAPteQKqY9qusZtIxZhWqDH4qOrgTNs5X7HygxDLykj/wD52UJ2P
 JKHGjNfcamSdXRWK0gwT770oDUGad8mTHeH35DVYkxUFvJtQTpat5Fcc/qvkIrtixwi52182s
 ANXkTSiBF6x7cq844LEOVZJ2rhKfDzbffXsLnhWapl6kDU5um79A03pEuK7VmPdndNZwv45xm
 nKNXrf3Bgmot0cuRAtHHyHuhcmq4Oj6c15yDFwn/RjeT0=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/23/24 18:29, Richard Henderson wrote:
> The return address comes from IA*Q_Next, and IASQ_Next
> is always equal to IASQ_Back, not IASQ_Front.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Helge Deller <deller@gmx.de>


> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 19594f917e..1766a63001 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3817,7 +3817,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>       load_spr(ctx, new_spc, a->sp);
>       if (a->l) {
>           copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var)=
;
> -        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_f);
> +        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
>       }
>       if (a->n && use_nullify_skip(ctx)) {
>           copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);


