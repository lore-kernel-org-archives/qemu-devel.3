Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AABE63CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 16:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk3Rs-0002oo-6m; Sun, 25 Jan 2026 11:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vk3Ri-0002lW-Ts
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 11:58:44 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vk3Rg-0003kN-Qp
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 11:58:42 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so2294270f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769360319; x=1769965119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0bBIlOV2tGYeFA5Ylr+lmNzjjtlhCVDAfjOTKukUTXc=;
 b=sQiPKeI5NapTzMuRIzQShe5MqT02CxesXSmAKoxNeLl9VcifexCFK2WR5XTiQR1fc0
 Ubv3ydDbru5nHhdMFs2UADdutuLGN6L+w/wPBKia5KBoMTDvKzwujDb46vOM01WfQh4z
 QlJNU9z4NKeyfZlzuxhgxuyI8sPYji1+rNoiBKdBguNKQp0KapOr2FNv+RAsEhdm2BuJ
 PcWWOux3iUnQJQ0KlY+0E+YSCny2+axax4fG9upKAarfHlzrPGRUkoyHnWebyH8FcjXR
 UtdamOw3gCmpmzllsi8RUlbjWZvYHEjxuPx7mxmEuX/hm0Al2WOxRId6nM0LE8UByvMe
 TWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769360319; x=1769965119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0bBIlOV2tGYeFA5Ylr+lmNzjjtlhCVDAfjOTKukUTXc=;
 b=s3qbefywTnIPfUUvJrk1fPob3cLys5h03jRso/RWBrY6gc0LG2AHXK4wMtdgxqywZc
 W1bEyg92Oue0aSMRyITIPo7h4n2RHBsk8dCY3NsQg/LZfNzPflbljl9acaLsUaGIltN3
 F/U3zsUxXBoJKxU4H7mmGaOwp0GYB/1q8Vy7bX3v7gFU/8wZlbEOOQkgOwkxZ55QtzTk
 kuuAOsb+cDJfbALCNwP6X2npAS/lyZtWMDFa0EgaUJ7if/5uu8oe9x9f3krIuT11nAHn
 EG1ktgtQcKoPQpbZCzRk3bhkIi/EKd4zfSbh7kWONLqLsYlGg60knnQW3yFmD53MeHs/
 JOpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy++ulzFyeNoZPK+qoskmJHH6UcL1g+A/csS4aqKdj4E5sJMs3/ufwapLA+/F7HetHrZsRT3j0RjIe@nongnu.org
X-Gm-Message-State: AOJu0YxucZegeTixAq+/qKnEbEyCJslPHdkGsTP8hXbXBEtJv/6xgcG5
 K5IbprjeYUFEICwXlo+tw8dXSPodIHFDcnCNv4a6a5cEs2+YYQOxW7mQJsp0feBjTlI=
X-Gm-Gg: AZuq6aLI1nuSM2r6ib0SScM92WmrOGe64K8BVars0nR+QXLj/5DWCJegcva44o+jb9b
 2CFwt1vQNMPZ1DwVHvuGNFVheCDFLqVe02TIssgya+K2q6Fx4jBvnY2cvZEsJ+M6FIen+wJyW0S
 bDhdUfD1D7sgYo4kS4yotWRNYL2GircY4NUh20kGpL/KUzxBL2iBUR1EMSH0Te61fsePjXzhuIC
 j+tjGI9kk/0U2hM7GalX000HdTvDi8dN93kk/g3zPFP2K0d/Qaqx7/YoYAuZHjvM44zSyEogNzw
 8vRuFPpSEsbm9rmBVI81G5zEZtPylQ/pA1obkQZI2ImpMjwfVWqUuIc4mJaW7SVwt6BDnmc0HWo
 HnkmXar+cLBdxvB23E/QGSh1Kx7GI3ucSTNfsXRPSMW2Lr4uekso/+WnrDxJ/d0HSqYfMEXqL07
 fcUsgYkwgqIRET4UzoDRraaAaRnMC0q0ruma8NZgTGr4jBNsuimmgFPw==
X-Received: by 2002:a05:6000:310e:b0:435:a370:2d71 with SMTP id
 ffacd0b85a97d-435ca191606mr3603174f8f.33.1769360318890; 
 Sun, 25 Jan 2026 08:58:38 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e717cbsm23387051f8f.24.2026.01.25.08.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jan 2026 08:58:38 -0800 (PST)
Message-ID: <ff71da32-360a-4e13-8033-dc461b85915a@linaro.org>
Date: Sun, 25 Jan 2026 17:58:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] contrib/elf2dmp: Grow PDB URL buffer
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-1-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260125-nvme-v1-1-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/1/26 07:42, Akihiko Odaki wrote:
> The buffers used to construct a PDB URL overflow when the "age" property
> is greater than 0xf, so grow it. This also simplifies the logic of the
> URL construction to use one buffer instead of two to avoid the chore to
> synchronize the sizes of two buffers.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   contrib/elf2dmp/main.c | 27 ++++++++++-----------------
>   1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index d046a72ae67f..83ddc57dd9ee 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -494,18 +494,6 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
>       return !strcmp(pdb_name, PDB_NAME);
>   }
>   
> -static void pe_get_pdb_symstore_hash(OMFSignatureRSDS *rsds, char *hash)
> -{
> -    sprintf(hash, "%.08x%.04x%.04x%.02x%.02x", rsds->guid.a, rsds->guid.b,
> -            rsds->guid.c, rsds->guid.d[0], rsds->guid.d[1]);
> -    hash += 20;
> -    for (unsigned int i = 0; i < 6; i++, hash += 2) {
> -        sprintf(hash, "%.02x", rsds->guid.e[i]);
> -    }
> -
> -    sprintf(hash, "%.01x", rsds->age);
> -}
> -
>   int main(int argc, char *argv[])
>   {
>       int err = 1;
> @@ -517,9 +505,7 @@ int main(int argc, char *argv[])
>       uint64_t KernBase;
>       void *nt_start_addr = NULL;
>       WinDumpHeader64 header;
> -    char pdb_hash[34];
> -    char pdb_url[] = SYM_URL_BASE PDB_NAME
> -        "/0123456789ABCDEF0123456789ABCDEFx/" PDB_NAME;
> +    char pdb_url[sizeof(SYM_URL_BASE PDB_NAME PDB_NAME) + 42];
>       struct pdb_reader pdb;
>       uint64_t KdDebuggerDataBlock;
>       KDDEBUGGER_DATA64 *kdbg;
> @@ -583,9 +569,16 @@ int main(int argc, char *argv[])
>       printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
>               (char *)nt_start_addr);
>   
> -    pe_get_pdb_symstore_hash(&rsds, pdb_hash);

I'd rather use g_autofree + g_strdup_printf and drop the _NAME definitions.

> +    sprintf(pdb_url,
> +            "%s%.08x%.04x%.04x"
> +            "%.02x%.02x"
> +            "%.02x%.02x%.02x%.02x%.02x%.02x"
> +            "%.01x%s",
> +            SYM_URL_BASE PDB_NAME "/", rsds.guid.a, rsds.guid.b, rsds.guid.c,
> +            rsds.guid.d[0], rsds.guid.d[1],
> +            rsds.guid.e[0], rsds.guid.e[1], rsds.guid.e[2], rsds.guid.e[3], rsds.guid.e[4], rsds.guid.e[5],
> +            rsds.age, "/" PDB_NAME);
>   
> -    sprintf(pdb_url, "%s%s/%s/%s", SYM_URL_BASE, PDB_NAME, pdb_hash, PDB_NAME);
>       printf("PDB URL is %s\n", pdb_url);
>   
>       if (!download_url(PDB_NAME, pdb_url)) {
> 


