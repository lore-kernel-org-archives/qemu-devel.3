Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDDEEC1E94
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 10:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnwTt-0003Qv-Li; Thu, 05 Feb 2026 05:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnwTs-0003Qb-7j
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:21:00 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnwTp-0007jS-2Z
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:20:58 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79518cc2bb4so4681607b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 02:20:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770286855; cv=none;
 d=google.com; s=arc-20240605;
 b=gPFQtGGSvWlTBpAI3Q7kD5h20aGQsx4eISOkc6B6OAyStAmNp9PUFmXgFtTrUMd49B
 YlxlNc27IfGEA2Bccuv3fzPNzoa8qu9chUMjqIg8WgfkN0IxdMHgmM5Hjdnm7dqUDIA0
 kLAaZXU6YPvdarP/uRXHP5CVrUYhV5T6WN7tY1wFGTTFpBEoD9ZXtc9NYDoHf2y7HOwn
 XxXIDaxJBoBQWAYvN4e2lf6cg5VVIoLVnZTXSlNISgrnaKKO17w9kpX4J5Q0xBqy78z2
 BGPfmGCngVogFlDT33ASgDlzo87o5s555i8kqKWVe5bOOc9zpvKx4O7UXLv7zLzPRJ4h
 2sHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q4E6LHdBSFXduGeeqWYUvrV147mNZsLrW4ry41IVI9U=;
 fh=09I2axr4uxBaQZWOq7eGnNEbjKYzXXuOZ/WYgxqbxRU=;
 b=KkKqdpTAxzaRRu4ftlKKQi5H3bucIu4wmBhCFSjK5m6k86zQ+neyqy5DtNnTljzBgh
 O+lVuiLeWFV6KhKgi2HbwigdpylCm4eZ2qqW/Jf5vJ9Hv3IuBDizBYTayhDC34QdL0nC
 xoAlqlGr2NtFouDNI6IP1wfYKX4L/jNbFVIyVIEOr+rvMpw/8p4zuiM63KEBI1hwC/95
 swbCXO+pZ8H0ltDR4M6hIyM6IxWfaj9KcaK1I5MSunrCmtfY1UpxR63BoOxigEP9nS39
 fYMxmV0Gdzfzd5y0iOU7rJGIDd4Ap+SHGWIcPEIBoZKusvqoXQLQMsJQk6W0Vd6yATY8
 f14w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770286855; x=1770891655; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4E6LHdBSFXduGeeqWYUvrV147mNZsLrW4ry41IVI9U=;
 b=sWP8egXS/eKDr12aowQ7c5btUPqbiI76IETv+d3Y2sMhsQg+//KLPCiUfFXWjVdpY5
 t9YGk1HCOglVG0GmioOXr9S8m5tdqWEj4IJSCcvyKPY1sx9EU09C1CPlVyp38dV+2upg
 /AX/cTPKZSqEPx6KpMjoDCCP5xMTX1ZV2FTszKSURKT/RPu5y++2FUlm3P7JQnADF98X
 NyTQovDVy3nImZzLq56JBTN8EZ+tmTa2j5siaWXcKaJ3j6TyRXuloZtjLiVXu9aSZYdR
 YTvgRgVBb25XBKbpzZEzQwSwm72j4wM+fKhIAUHnq+YEnqdcY/w8EM6tMEM3D4U4tu4u
 tCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770286855; x=1770891655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4E6LHdBSFXduGeeqWYUvrV147mNZsLrW4ry41IVI9U=;
 b=mm6KB9Ai1tRyoPp+c8hpsjLMIILBb+PXmqoBmrp3ANb3LoOwkEG9lxGiks37nF2WQ9
 sA3wPSnxYhFhfPLzsyJ+tBYD1IAmbXJa1gPSW9uvbpb8oBgtFStTLRIpEIshL7XKS0Mv
 syxS1ROqeewRJ0cRIuiOohWIQg397XIjfLC26fuSay3BSrTKHEKEgmq4tNjue2tCcdQJ
 qVHdCSNTKne7BS1iEt995M+3B9WD1KsKxSY5Gm8w/CJaCpAwnzLOPyw6jSrg2fnGyXDP
 27UyvAZpN/BXgCh1Li+AdV/kMF7Kwd9da7gEXoqeL1GZ8jHDw/7EQ8btFInAwlGhoMZt
 CG0g==
X-Gm-Message-State: AOJu0Ywzu2U1pMplp2fXFlXTeoWWyNLNB6MBNd3aWpRrsLlwqBNOtXvS
 UZq9sE7W/TOs1q7omI6GYUWI+lkEa8TBOo+wF4kzzgrToBrgUeewJFR02hO+eighrOGWIuDLIeS
 HTFMTYyn9nTdLH2mKaCQjIuKjVgG+zHGyX+oFMI4UNQ==
X-Gm-Gg: AZuq6aLhFBHKMZGktpJEOxmLIpWay8fBsThA1fOpawR6p+vm8+lVR/qWnpdkosvWpPp
 MxUH7gPvV4zkBIBYijyUncm3QRoaSdmEXDX1PZ81Mmpji3MdYWLpTvBcjBPIQ2ngur0TGzEWHrG
 aO0z9Ji3NhwLVNyvO/Uct0h+0WXNnDQT5bt6cLtNzow01kTO4k9PD/JYWEtwpgowgA/vmsHaJ7o
 sGm/qdK1F/ercoHKYw+c0ZznoiaO08hY0tWazwCu+QT5vSfETBRbKQWm2XgdtziHb54Mg==
X-Received: by 2002:a05:690c:f14:b0:792:7745:72d0 with SMTP id
 00721157ae682-794fe70f3b6mr52950947b3.23.1770286855563; Thu, 05 Feb 2026
 02:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 10:20:44 +0000
X-Gm-Features: AZwV_QhwkRr6LRvTHk7X7jjSk2flE715Dw6qYSH7QRauPBTxA6SvPseQCCnBACw
Message-ID: <CAFEAcA-4-nwRQCaa9SRUv28SWveC7k0GG5HmA478FhKGuJb_fA@mail.gmail.com>
Subject: Re: [PATCH v19 00/22] WHPX support for Arm
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 29 Jan 2026 at 19:20, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v19)
>
> Missing features:
> - VM save-restore: interrupt controller state notably
> - SVE register sync: I didn't have the time to test this on pre-release hardware with SVE2 support yet.
> So SVE2 is currently masked for VMs when running this.
>
> Known bugs:
> - U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.
>
> Note:
>
> "target/arm/kvm: add constants for new PSCI versions" taken from the mailing list.
>
> "accel/system: Introduce hwaccel_enabled() helper" taken from the mailing list, added here
> as part of this series to make it compilable as a whole.
>
> And another note:
>
> Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
> so didn't do changes there to a sysreg.inc.

Hi; this doesn't apply on current master now that the SMMU changes
have landed, because of a conflict with the ACPI data table
update patch, but otherwise I think it is good to go. Could you
rebase it, please?

thanks
-- PMM

