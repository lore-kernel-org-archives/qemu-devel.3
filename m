Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01D9C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHQn-0000TR-0s; Thu, 02 Jul 2026 09:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfHQd-0000NX-PJ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:26:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfHQb-0003zj-Nb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:26:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493b7612475so15204695e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782998763; x=1783603563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPdU9alilOC46cNSb0QUT3hcuEsh+BYqs1VSXbi7f28=;
 b=HjOW34clz3UUjLoDve14H2E9+HsWBA5s8hVkH0OHsuoFlWidtmTNQZyL5rfU/cZWt3
 3MplR0BNkcrovnYWT/IooAp52HA0elJx6rW5/f626rYEl+Yx2itZ00T1PuVMk6OLcwVO
 G1AGupbmWYDp1j7qip6z7DH2fpFG1QwWZVfmGakmvI6GEP+PU+LJisV/N/RI4TD8oyxZ
 9tQR6yi7FNbj2cscauws4oGhCPioqwJ2kbKHZCMPPr47vzoLWraaNANIj2ZAnRBX6iTK
 T0e7IJ7Dt88URsEtQFgKf94+OtbNXw0nOH6DEgn9NeE4RwCfsvecEA0aUwprCSEDPHFo
 cizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998763; x=1783603563;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPdU9alilOC46cNSb0QUT3hcuEsh+BYqs1VSXbi7f28=;
 b=m7j3f2pOtK2hUfB5i95eSNPkm5mp3i7vTu/PMFv/5KFQ1qnPSQ0eTfzVGFOzpq6Sr/
 98k2zqhVP+LN+qk+0kshALZd8pk6Z0XEP0rNYoOAFSq736nAVhPQ6UNgdJ5oYNMp3IjC
 Et6tW0BHEgTFphTjTGKAGRImk8PCmAXayBkQuK4G9v99nQ0qW5T8PLBZ5+5RS5EfjYEf
 YKsKVcv0PrrekJ/6NPFY6hpWdIMhSWDNOHI+fDJpriP8qNIF7CU95Uv2xKCuVcLeuznB
 uaSXh3KNdEJrioujjfJYRBtTrgKruD0/M0gbS9OVvKV07WAude1vnNdOimAcpaXpqKHn
 Ebcg==
X-Gm-Message-State: AOJu0YwpfoRlO/SeKMrNJgLC5tuIVrqbu64SKKkAw0RxyGz6lZLcV0Un
 sJ2TBO3Z3fJnyeHmawiPeKNuOy6qxMUkVPq2+5+s7H9B0zBqYaOudgM97BEUJ/01SSk=
X-Gm-Gg: AfdE7clWgQCoAR1DbfAWHUHw6GmMsWW//RH7aHtveTsTc2xeeJTr66zf+duj/YzeFSD
 onrZzodze8FN2kFpuzHaLGiaOlv99v9avX5pSgbIxjEdJCtZhMCwXE3JSpMdf4KvD7pOHfzt3aH
 9KMdbq0cTxWuPMQ/w9te2N/k+pwXe45T0TE6nPrNQHzntNNL6DfbUGSnqxgMSQWbvxv9MujSk5L
 wrbvmkJfx8dOve5TBPv/PzeLdCHgvi4qvGRrtR2bu+AhdNAonBxZmgycpIMEr6xuq+jBRuGe2gG
 vK4b+/HNRlXAVXlXJy0+/D64gQh8jLdYPRdu7rwpE8oRZTDr84GsBnfhjTHnlJVgO0ZAihkh4hS
 5ZkbpGe4YEM14oIV42cK3JThrfyOmmrEssFTO/fpq06n1dvwVTu+wVgGihGJngV32FKnIFDxVaf
 XBuyzuGdVEDzmAAuePcVCfdFM=
X-Received: by 2002:a05:600d:c:b0:493:aa28:38ad with SMTP id
 5b1f17b1804b1-493c2b4442emr64776085e9.10.1782998763143; 
 Thu, 02 Jul 2026 06:26:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6354771sm52751585e9.3.2026.07.02.06.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:26:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 615A55F89F;
 Thu, 02 Jul 2026 14:26:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Xiaoyao
 Li <xiaoyao.li@intel.com>,  Chao Liu <chao.liu.zevorn@gmail.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  qemu-ppc@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 07/33] gdbstub: Only return E22 when reverse GDB is not
 supported
In-Reply-To: <20260630220100.1289-8-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 1 Jul 2026 00:00:34
 +0200")
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-8-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 02 Jul 2026 14:26:01 +0100
Message-ID: <87y0ftsety.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> No need to keep processing the arguments when we know
> reverse debugging is not available.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub/gdbstub.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 246e7746300..f54415a9db7 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1378,6 +1378,7 @@ static void handle_backward(GArray *params, void *u=
ser_ctx)
>  {
>      if (!gdb_can_reverse()) {
>          gdb_put_packet("E22");
> +        return;
>      }
>      if (params->len =3D=3D 1) {
>          switch (gdb_get_cmd_param(params, 0)->opcode) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

