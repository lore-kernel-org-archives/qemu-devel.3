Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A1CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 23:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcAZV-0002P4-Su; Tue, 23 Jun 2026 19:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wcAZU-0002Ov-Cb
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 19:30:24 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wcAZS-0006jF-Bn
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 19:30:24 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-662dc387b7aso431928d50.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 16:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782257421; cv=none;
 d=google.com; s=arc-20240605;
 b=gvpyGnnZFs9sW6kcIw5d556dme5/iglUX85Tg4tNJVfV7jsfw/DgQ/l5VkNAkmAYq7
 pAYuZInAa6Jjp8J+Q6OR2t30dD5tVAKhYeNtfX7aZIouFEG63t9BpHQaZh2ZMnI0E7V2
 +S4sd05J4j41KZ8CJHtEOpnVyPlbFQwYF2Yowqnj1LG0sDe9wMY3Wc7Y7OSHOPCBdheq
 pDfkaynijHIxHulG2b5QJA5zeMdegDRouhwAPtJoHagnGAnVkrV26qtb8c25+GdZLau/
 oOb6USH/V1CRyiY+TVpXFl2VFuh3/oibvHSeujoN04xap1iPdA72Al5YbyfUa3iBITe0
 XKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wzThTmL9Krr6krYkgok8TfKGyuE5574St4rT3Y4+0k0=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=XYvY+MpsfAAywNzBZM/txnKud/xIF36Igx8Vo9V9EmVpx3wwRoATsiTxb4wwo97GF0
 E55Iv/HsdtO9pCRWJdq/BcZOoHZWBLMKdlo7bS1Kudpzp7o4BGfa42zaP7Gg9rRLk03P
 iIegk7DWngqKdO3vr1EUeXX7TXnQvSUtSjMh0A/40lfofriQw5P4+UinAkp34Wxt+EHQ
 z/NF3aYaiwAclfsN3n5cHxwr1OQYV4CIKaadC3PSVA4ZQdz+CxuBF8EV/YFkGewgPJGa
 ftAZi1xLAZGM6eBzYNkSBIScmbVu2SqPWs6iiplpFaOcmOfeoazHqfVy45BLpq+lUnGo
 nd5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782257421; x=1782862221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzThTmL9Krr6krYkgok8TfKGyuE5574St4rT3Y4+0k0=;
 b=dmbguRHSL5ymEch/mmnQGYn6TWGb16m3QIPSe9Dibt98jMwbVHXCgS+iDLPrJW9Ngl
 qPHTr99/z5JPJ/25TVenw5pBIZVl2j+yQoc48iEICS3TlB6EdCM1xTD58SZ5RASeTiXX
 VZ7RAN1TAlfQg2lBBVu5aKqKSucwWkcpAiqocF4GFRusyLTvvPADTjTBdydtRP39r+Co
 v561i17nvQE+Jn2XFWfvWROUaPSGHjQsmZMg533UV/ITrIIw/oiKfhXghMDx5L4uLsEn
 kcQWbyRdUAQZ3Ngt6l9dvESW0F6OZIJHU2nDB0IR+C+cizm7hgdUgSmkTqVcG6cBZ9ZD
 xT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782257421; x=1782862221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wzThTmL9Krr6krYkgok8TfKGyuE5574St4rT3Y4+0k0=;
 b=sxAEvPWiA1NlvjcWxyb/ARbbdKj9PqRZNzRZx5/9pZ4hiO8k5ty7UeHshRz+PDbKiQ
 qNar7fDS9vCqL6lFgxw9t9XVInEigDlvwrSjHqDQ+xm6GZWA3EmX1o5C65k8gBxtDaga
 adOBYQs7Hob3jQzqsrGGK9W9Av/oDhEnOt+6PWWtqSwTxf3tGfXFJ9WlL46sA6QRzJui
 YsxHvy8KkxT5sKJM7oB5u7pFZLfGJRrUoXxaBJfg0Lqs0xpEv8JhnECQpcbl8643nHey
 2rDVukdXRB0E4BJU+ZP2Wp8aAyOoQ5jfgYMydidn4ZYXUgrqeXPQXb73w1AF2rCMstmm
 8SiQ==
X-Gm-Message-State: AOJu0YwXLfF9MZ7SrhA8mKeYwS4dk9yWdCbrW942sOHjHFMURHKGok6N
 oh78WHGuWVvz2JmGYFxAbjFL8XgAQUAMr8/pZyEi+08UsHFZIpqZqMQ5OpQuOjpvV36p31REHWk
 SZ5HxrWMZRYVW0vbt3q1u2OJo1jpoVlE=
X-Gm-Gg: AfdE7ckQl4T7H5TMLNucWKf4bLXd1pVjNSYWrUdAdQkRgLDsW93/FDWPLA+gnAWeSH3
 GNkQeWLRA2X9uwxo+s8j45cHQkR9gXhcXhRjJLbywVDC5BxEjuBW4qJlfYgiETwFFaP8NaROdzX
 dZtW9i+r/StxgSpQF0EtqXHEgzO89+kFjc2uezhSuuUrfvS9okjbeMpqxfG/M2EV5ABn8RAU/qB
 2S0KZ/siaNQrYA/L2mIm8+TmZP+hlhmUlRlR+hVIw+MQmz6AOPkQnLzpTJJmbrBnx552tIkbFdD
X-Received: by 2002:a05:690e:13cf:b0:65e:a838:e9d1 with SMTP id
 956f58d0204a3-6636e6711d4mr917599d50.59.1782257420454; Tue, 23 Jun 2026
 16:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260622113152.1710585-1-berrange@redhat.com>
 <20260622113152.1710585-3-berrange@redhat.com>
In-Reply-To: <20260622113152.1710585-3-berrange@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 24 Jun 2026 07:30:07 +0800
X-Gm-Features: AVVi8CcWZxZ5JChatq92Xvov4q94Orlzkhr6yTI5wAav__d-EGziemo3yieARYY
Message-ID: <CAEUhbmVzi36AXYWRztjZkeEqNpYFs6HnaXr6MRQxUMcccAWA_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: record known Git Lab handles for all
 maintainers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jun 22, 2026 at 7:33=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> This updates MAINTAINERS with a "G:" line corresponding to every
> "M:" line that can be identified with a match against
>
>   https://gitlab.com/qemu-project/qemu/-/project_members
>
> This update was done using a largely automated process based on
> the data extracted with
>
>   $ glab api --paginate /projects/qemu-project%2fqemu/members | jq -c '.[=
] | {username, name}'
>   $ glab api --paginate /groups/qemu-project/members | jq -c '.[] | {user=
name, name}'
>
> Some Git Lab accounts had real names that didn't have an exact

I believe the correct spelling of the product is called "GitLab".

> match in MAINTAINERS so the glab api data was manually pre-processed
> to change those names.
>
> A Perl script was then used to insert "G:" lines for every "M:"
> lines.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS | 332 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 332 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93df53d87f..9a62fe0e81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18,6 +18,13 @@ Descriptions of section entries:
>            These reviewers should be CCed on patches.
>            Reviewers are familiar with the subject matter and provide fee=
dback
>            even though they are not maintainers.
> +       G: Git Lab handle to assign issues to: @GitLabHandle
> +          Maintainers must have a Git Lab handle listed. The handle will

ditto

> +          be invited to be a member of https://gitlab.com/qemu-project/q=
emu
> +          with the "Reporter" role. This will enable triage actions, iss=
ue
> +          assignment, and visibilityof confidential security disclosures=
.
> +          Designated reviewers may also be listed at the discretion of t=
he
> +          maintainer.
>         L: Mailing list that is relevant to this area
>            These lists should be CCed on patches.
>         W: Web-page with status/info
> @@ -58,6 +65,7 @@ Descriptions of section entries:
>  General Project Administration
>  ------------------------------
>  M: Peter Maydell <peter.maydell@linaro.org>
> +G: @pm215
>
>  All patches CC here
>  L: qemu-devel@nongnu.org
> @@ -84,13 +92,16 @@ Responsible Disclosure, Reporting Security Issues
>  -------------------------------------------------
>  W: https://wiki.qemu.org/SecurityProcess
>  M: Michael S. Tsirkin <mst@redhat.com>
> +G: @mstredhat
>  L: qemu-security@nongnu.org
>

<snip>

For my account,
Acked-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin

