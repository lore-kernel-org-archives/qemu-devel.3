Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A9DCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfI1-0003vO-ND; Fri, 02 Oct 2026 11:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCfHV-0003s6-Hy
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:34:41 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCfHR-0008TD-Ei
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:34:40 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2946aa0d5aso18823766b.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 08:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790955275; cv=none;
 d=google.com; s=arc-20260327;
 b=i3fxtK+CR0CVN7wcQRXC00AuJAoggpZMxpJRqg0ZHpNf0+cgwQyi3T1/Xh2PfGszTm
 xaiF1m11q9gNLAu2Pox0sN5+LPVfwjBgHapUUm4BqG9MUjeSCW+GMfxR0YXh3SL5zBbW
 2dLaqV0mUYSPLEw2QAuTRf/xK82P+ykDu7falTmY7dPg8R/i8Rde5YfSzXNrVBZA5TX3
 Sh8AYrcDP8uvYFLH84YcGqk3UVJR+jGmfMbb8ozeJTY8H3+t5Vs+Um3Ej8Ak28mn/Br+
 qhYcNzhSXl30Asvvbl6m8DXPSZudGR0GUXaNIuIrae8wt3PRQNfBe84Wu0FF9TpOC6Lf
 72PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=kDVyO4NYmZSyEcFDGjVinlfID58sslSyPvBYMsluzYk=;
 fh=OKxlFcZPUvkxrTVNBc0wmMJLO0A+PHSRIcmKHa9sMDw=;
 b=C3TqatQJSPgcdfdmfAANQF4qWwqqNVKdnT7mYQyrl6i5H3g1dnnKDXAJKq1kyK7ud5
 Fof8e2BWYOqcaso+p8s71sARuMQj0fn8J2nY5tA1DU7b6sD/oyKrwgdH0HBNILm7ahCB
 vajgBgpT32bFra0mOS47QHBOnPDEMnqcyN3n4D93oXYlzILuvRq3w6Z3MMZLJNIdb354
 jewXlynAyFSQTanEcQi9K1JC06rdfSDaP4FlPo8y/2DGnCXD+ItbDi+bUT4SuusZjb7o
 OQiQ0/qg0Q7GEXXJ64vRDqMYF7e1Fj3TnY/aMrKtfE2m1+yO0FysFfyPbHlb83UJQMts
 3AKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790955275; x=1791560075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kDVyO4NYmZSyEcFDGjVinlfID58sslSyPvBYMsluzYk=;
 b=hawoDyV1ZS2+pgoaBeFrZyXm/6Z4d2g5xKIu0B9kjw60qrhm+Z5TzlMjGZ4PeRZKvG
 TTa8aS72alE/tLIHK3hKYSc9wIUsmYFxWqLgPfrbmmQEoqNsXnw5JdtYfmIhDxu7jyBv
 HajIDGC/SacduTNVCZMOAYHNcuxwNqndsWS1uar3iu0QqCTfZa+G3G74QO2nV7ufbLUB
 oYy+A1dWlcdMmLbgfvQYuLYYdKlgvZuGbYaj9BTJmIiKRyxCaPUc3zv5SOAojzDAAT8h
 /Wjhx8HKXkug92yzLkh76wgbQee5czG0fVtriRvxh2bJcwos6WdZBYHgqieHt8nzSwBr
 OvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955275; x=1791560075;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kDVyO4NYmZSyEcFDGjVinlfID58sslSyPvBYMsluzYk=;
 b=n3YzUZGE8pfLQBlR/GQ4zDvZ6qtqPQFqdrE8cehdTZ1hCAlrm/wBv2e6wS10Xv1TH3
 685UMEPt/2pqW2NyH0IfeMHNetQkwIsF0OxzLKliDU1rzOMehkp9gJrf0+4OejHzFGa7
 BvrIiclESaXueXhgd4geoyXodTWSZmoPbFh9LQ0beejVolVWU1xHv1Jq33mUc+XP8XLM
 BNNNJ29/BKORv1VfoTrmr/hE5EI/r68lxuVAEsuCxgz9GgIq0fc9hL665tgIeM6N/7zU
 wGzHJtS1gBzn0Ni/zbLFkxmJySDtdatnjEfEEZG7aYD2aVD18qxLEjem13X7WDYD7S1k
 pE4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJJf+xQGyxIaou1/wLA7C+hGSsh7diHkwQUsNaRnRO7Wzs7by7lsr9w8V/vQLhhsUBpXQXNfYEu/PO@nongnu.org
X-Gm-Message-State: AFq9FYIjnM5WLJxYcU4gOLgDq0JIvKcm/jItZjoLjv2tNkFrp4wtjK4m
 isriRQCpYwf5oH4DJpIGawCSPxPY3KEhVGuA8xNhoJ9uYb6NTykZ9iJE2/TrZftela3pMofTqPe
 kSKYld6IzSQJX6XMCspr/iahQ3L+Q1Ho=
X-Gm-Gg: AYBFou2+kN32tCMM8zPH/A4VlVXubZoj/fOtm0fw7jgVkM1nLRKKhyg8AAaQsQdEIoz
 wFoBkFCqGk/6ydrtP9yDwA+/Jppqy1ETQUlXx4QlJTigbfQUR06s/daz8Cwf17RMalRhzs5rDJH
 WufKhwDmQIbxx/hOfXq0LDF9Oi6RLU7JiRdv7R/B19Cf4XPfBV9b1Iszr3afq8v97L669+r9w1r
 4OBAGJtEtrCmLhEyfvyJAPrX7PMCW+szHl6TLElokhlSkuCBq21rCG4eLi93BPuF8XjCjQKmzp8
 usqwUf1KasbIrpFdil5a/c87CK99Sey2Y6wVOkyKaCdJClzKrzMZ+0Y=
X-Received: by 2002:a17:907:94d1:b0:c29:519b:3aee with SMTP id
 a640c23a62f3a-c2e340e2e71mr532777666b.33.1790955275197; Fri, 02 Oct 2026
 08:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
 <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
 <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
 <ar4TQtKqfXX5Ul9O@redhat.com>
 <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
 <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
 <ar6a_uDw9OeLng6c@redhat.com>
 <6bf4dad5-4fa2-4df1-b6b8-d594dbd3842c@oss.qualcomm.com>
 <ar6lw3jAcnVej6vK@redhat.com>
 <557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com>
In-Reply-To: <557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2026 23:34:22 +0800
X-Gm-Features: AclHuK8K3-fC5Y8WBHMwyVj2hZYdFA6uhOSTNEDEN4oJp2SkNblgDU5m37PaQ94
Message-ID: <CAE2XoE-nPoGegAhSOyO6W_JZxmfw6RTfJo532rFAmHUJUdPVPA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Song Gao <17746591750@163.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 2, 2026 at 2:56=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
>
> @Yonggang: can you try to provide a RFC based on this, to see what it
> could look like? No need to cover all machines/cpus, just select one of
> machine+cpu, ideally with multiple SysEmuTarget (like virt and max cpu
> for aarch64), and let's iterate from this.


Hi, I provided the RFC at https://gitlab.com/qemu-project/qemu/-/work_items=
/4635
Not sure if anything is lost, if there is some, I can update that
work_items easily.



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

