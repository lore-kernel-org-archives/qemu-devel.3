Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBCACD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXx9y-0000I0-6I; Fri, 12 Jun 2026 04:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wXx9t-0000HT-TQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:22:34 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wXx9s-0005g3-9w
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:22:33 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69170548d0eso977541a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1781252551; x=1781857351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1JOSGinv+7tUEI5gb4kXt7A3fvxesQBbn1jYZ30EgYc=;
 b=ZwVStloBwS+eKk3rldcmJcokW6CKhfUn9AzIJ6qba7FJZdzpgAf1lE/fzHphVXo1Ac
 kT1eVYNFFNUU/zd1J8n3oWkjHe0+jMfz/FXzJXrkcIEEcGb2x43g+TQMg/VHjsyvyAV5
 3us7LJsrYOI8ikjlbtCYmAlVbZqh/dIjsaWDTXcs0qgLafqwDtrMDC4K+260Is5L8mU7
 uT1bLLiYLhgJKIxQk1izizBnlfqNbEUsFC4nvLuQ9Fz1vO5Ykpp7c0p39PJz7Lxa6H/D
 h2lr+euq++c52o4d/ydmNiOZv8rJGNVechT6qEr0NViKAFq1yrZzk38+4arE+4JFhgQv
 VrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781252551; x=1781857351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JOSGinv+7tUEI5gb4kXt7A3fvxesQBbn1jYZ30EgYc=;
 b=RjNYDZNbakC+ick4I4wGpKNXzhkEJXXD7BiK0U0IpEpWHc2033iLzXHI0ISttUzMQ5
 oqIGEt4r5wB0tZ4ebhco34JdJ/0rcHRKarkQ1e50dXqZvm2z7hQUOD7fX6RELWyY/gdk
 IxtWBIE0BLbqUwKc+W0rNxBtzNCIJu1+sqEy91v/+5ZVPluJi/a2Opmfon7bAuThAn/x
 yku5nfQY9W4/R/rW31pItcEneW0a0B32pClknZKCRC6FvcWsKXOROvs1Ga1ouqFKa1m/
 eEbXmZ0/VX4tZIUbu4hVQqwWx39gSDSdStqLmyKIqA5j3A9fdMDTIOA6zPb+I2n3xsFS
 /2tA==
X-Gm-Message-State: AOJu0YwkkGrQz8UwYbAx+GURQA4p99AmTTKllEzyz2Q5heqv1qp2H8Zh
 G1wP2kjwQWAqIuqU95pWI7Kw8gNFC680KHBHAMioctX7XApFqCmB0ivn/k3tCjbkWw56V3YQy/d
 bZStEnvOBJRWpE01NNVgg/aTkBxFdfMua/r4u2rsWBarrks2lgdEsUiqsx2q5qf/4yTVLzoW7DY
 PN9wL5NGOrRA8TH7G0fYaMla+71G1Z1Pui1XzNHwwyFdw=
X-Gm-Gg: Acq92OENLRbqSsYimeAI82xb0JGvyItVEdaPlVbFkIxR+PIWRagpMp6eJX6vKKk+nxZ
 z9ZbQTXHO77SGLssdMSKcWwMdFCxr6TAxgRkqxtg373NVh3gpOg6gr4IDX/9NenHxnqOOsIjF1X
 lAiPu49Vqa89BXMYf4exwqJVp3UWQVHP2CoQ1bB5nFM8MfgRE+7hgtNQ5lFGfTPZS30IezZ1NZ/
 KY661xz0e7J8oKqm0RfAva0e9Zl/3yIsMI2R0JiMIxdcywbIf09mOAWVr3cuStKfAFxjKR7Ivxe
 pb8JwXqtWnooFSvSrw+MssgaCA/1vuJXwSpFKZ8oTnSf4HgkNPG4Xl4b6bJ3ayuTDJO1ceR4Nbp
 jt+kyHj+E3NAcwf5wmdeDVdqR6JDReo2M+iAQy/gxQcbwoIXR6h2u6ow/C8tzO17R0ArQw3a8xO
 JuEp+TLVJyhF+wST09HE1QzYSiCjPFhq9ytKo83Ajwf+Sk0mCU8z9w4jvMVhP+VwvZ6+w4RFM=
X-Received: by 2002:a05:6402:1f01:b0:68d:ad45:5cac with SMTP id
 4fb4d7f45d1cf-69378601f3dmr726331a12.3.1781252550612; 
 Fri, 12 Jun 2026 01:22:30 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937938ab02sm340292a12.17.2026.06.12.01.22.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 01:22:29 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so1158958a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 01:22:29 -0700 (PDT)
X-Received: by 2002:a05:6402:e02:b0:68c:3994:45f1 with SMTP id
 4fb4d7f45d1cf-6937860404emr676301a12.6.1781252548784; Fri, 12 Jun 2026
 01:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260318185238.99143-1-luisccunha8@gmail.com>
 <20260318185238.99143-7-luisccunha8@gmail.com>
In-Reply-To: <20260318185238.99143-7-luisccunha8@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Fri, 12 Jun 2026 16:22:17 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZTOA2KyL+ab9C=ut6a9VUtOL7WawzL0rokZLpaKw3__w@mail.gmail.com>
X-Gm-Features: AVVi8Cd8mz00-7dTryuYE5-Lu26EU77p5kuOf2zN3ZBisuQINgaxe3Suxd2G_1Y
Message-ID: <CAMXXpfZTOA2KyL+ab9C=ut6a9VUtOL7WawzL0rokZLpaKw3__w@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] target/riscv: Add CPU properties for SPMP and
 sspmpen
To: luisccc <luisccunha8@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="0000000000006d273406540a2df3"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000006d273406540a2df3
Content-Type: text/plain; charset="UTF-8"

>
> +static void prop_sspmpen_set(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    bool value;
> +
> +    visit_type_bool(v, name, &value, errp);
> +
> +    if (cpu->cfg.spmp != value && riscv_cpu_is_vendor(obj)) {
> +        cpu_set_prop_err(cpu, name, errp);
> +        return;
> +    }
> +
> +    cpu_option_add_user_setting(name, value);
> +    cpu->cfg.ext_sspmpen = value;
> +
> +    /* Enable necessary extensions */
> +    if (value) {
> +        cpu->cfg.spmp = true;
> +        cpu->cfg.ext_sscsrind = true;
> +        cpu->cfg.ext_smcsrind = true;
> +    }
> +}

 Why do we need to set it again ? So if we enable sspmpen means enable spmp
at the same time?

--0000000000006d273406540a2df3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">+static void prop_sspmpen_set(Obje=
ct *obj, Visitor *v, const char *name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0void *opaque, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 RISCVCPU *cpu =3D RISCV_CPU(obj);<br>
+=C2=A0 =C2=A0 bool value;<br>
+<br>
+=C2=A0 =C2=A0 visit_type_bool(v, name, &amp;value, errp);<br>
+<br>
+=C2=A0 =C2=A0 if (cpu-&gt;cfg.spmp !=3D value &amp;&amp; riscv_cpu_is_vend=
or(obj)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set_prop_err(cpu, name, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 cpu_option_add_user_setting(name, value);<br>
+=C2=A0 =C2=A0 cpu-&gt;cfg.ext_sspmpen =3D value;<br>
+<br>
+=C2=A0 =C2=A0 /* Enable necessary extensions */<br>
+=C2=A0 =C2=A0 if (value) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.spmp =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_sscsrind =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_smcsrind =3D true;<br>
+=C2=A0 =C2=A0 }<br>
+}</blockquote><div>=C2=A0Why do we need to set it again ? So if we enable =
sspmpen=C2=A0means enable spmp at the same time?</div></div></div>

--0000000000006d273406540a2df3--

