Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5002AC02191
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tchjG-0005ET-Ia; Tue, 28 Jan 2025 04:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tchjE-0005DL-QX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:17:52 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tchjC-0001rA-Pq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:17:52 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so7759776a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 01:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738055869; x=1738660669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HK6HlNjsCcZFlNf8qgdrXhbEsiNmXf8mem+sjkM+hoY=;
 b=Jhu0b0b1OC2uxJ0tBiUlZIbSlVoNxH8RivkdR/Jo8Rkf95VeidaeP//5t4fyquMCmI
 eLvSLzKJSuxJvoguhdMkDGTRV6fyWsxsyDKR8QOULzr60WRNei8tqbP24RUQ+NDkkGKF
 7r01G2E4VtS0+6vZvm+jRpcXGhFDM41YCmxmzeQlnml0p+XpTUWyq/9Bd9q4RSCtV/XE
 eimKLOeYAku4DaiT0IIdwYzxtl9FK8N0sHKVrfoHoUTrn0ir06wZDxt1x6y55snTmBeY
 6GXTOTHE930BxbgsY5Nz9SRtHA0+bt/1MtCu6EUY0KgAXqXFIkoNJZejmR4mked96LVm
 WCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738055869; x=1738660669;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HK6HlNjsCcZFlNf8qgdrXhbEsiNmXf8mem+sjkM+hoY=;
 b=NIDdP89qFRX+bRLTRymoC+IEa8Tfdv9kxYXamXwzwRAdKi8wd6TwtCmddcyV5NVE9v
 dC8QCDXBNZ1sW3qDt3GZ0OLE9sLYhy7BtTscAh195y1k9CrTEtDyBRh6Tj/diQ8tJzzX
 tJIEVZBOjCLT882WVT56SMyQrBNPJ0Bfz6G33TiHQvngfVrGJ49DeEVJHHF+ZYTDRhOj
 Vs/xJMccJLah9K+jWcMjrHjgSkgoucVu+VVL87Ae5FCdWYqPojsN+VFOSg4qLEECA5tT
 uRdsplV8wqcJa+bb7WQcFYNoRJF3RUQgA9dBEzDZDU0tEquPG7Or82qkaZLnJKSYUJc0
 Im1A==
X-Gm-Message-State: AOJu0YyjFhfvkDZrh2nq9XS7+ftpSI2dYVYGxd4mSSro8v0JXMFN/uK4
 nCJTZJP63zvSpfRAM6+yPrNrA5Gz9Qyv/TtvJ6FRDceKqyuTpQUnDo/Pm6oXvBw=
X-Gm-Gg: ASbGncuqKxo67Uhh3sQ+hi+iVMDU2A6q3jwfxrkdaar6ov/JwCPzmePlKQpTVu7vgN4
 KfAaU2Gus7kxFo9y6qQ3rp06HhyQ3EVGWZ6uSfsX1rwv4JbL4J6Ssgxu3pD4kfUQ+luZWrlGjMl
 BRJUpbAkgUY6Ku2/LmFD7O+/xD0/y2a5ZxpyGJ2buKD/aKINstUQyQ+RFsqBMRWIDZ3gKIo+gGk
 qt779wDuOHHwQH72FpV0thEJy66G2Otmp0zUtRAfEfr+AfcbX4wUshT7EFDmjZem6jp32TUQG8F
 JUP15RjQjZcXyA==
X-Google-Smtp-Source: AGHT+IHcnI1fG8BlLaSVUxW7qTqzD5ukaNrE29u8Utd5U7KJxqWFZUtMgIIWGVXDPzEroZr3SDeVZA==
X-Received: by 2002:a05:6402:2681:b0:5d0:8f1c:d9d7 with SMTP id
 4fb4d7f45d1cf-5db7d2dc2d0mr106537764a12.4.1738055869083; 
 Tue, 28 Jan 2025 01:17:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc18628919sm6923709a12.25.2025.01.28.01.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 01:17:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C74105F8D1;
 Tue, 28 Jan 2025 09:17:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Luke Craig <lacraig3@gmail.com>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 2/2] plugin: extend API with qemu_plugin_tb_size
In-Reply-To: <20250127201734.1769540-3-lacraig3@gmail.com> (Luke Craig's
 message of "Mon, 27 Jan 2025 15:17:34 -0500")
References: <20250127201734.1769540-1-lacraig3@gmail.com>
 <20250127201734.1769540-3-lacraig3@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 28 Jan 2025 09:17:47 +0000
Message-ID: <87ed0n2t6s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Luke Craig <lacraig3@gmail.com> writes:

> ---
>  include/qemu/qemu-plugin.h | 10 ++++++++++
>  plugins/api.c              |  5 +++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index a1c478c54f..1fa656da82 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -476,6 +476,16 @@ void qemu_plugin_register_vcpu_insn_exec_inline_per_=
vcpu(
>  QEMU_PLUGIN_API
>  size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
>=20=20
> +/**
> + * qemu_plugin_tb_size() - query helper for size of TB
> + * @tb: opaque handle to TB passed to callback
> + *=20
> + * Returns: size of block in bytes
> + */
> +
> +QEMU_PLUGIN_API
> +size_t qemu_plugin_tb_size(const struct qemu_plugin_tb *tb);
> +
>  /**
>   * qemu_plugin_tb_vaddr() - query helper for vaddr of TB start
>   * @tb: opaque handle to TB passed to callback
> diff --git a/plugins/api.c b/plugins/api.c
> index 7ff5e1c1bd..177f0ac9b6 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -241,6 +241,11 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plug=
in_tb *tb)
>      return tb->n;
>  }
>=20=20
> +size_t qemu_plugin_tb_size(const struct qemu_plugin_tb *tb){
> +    const DisasContextBase *db =3D tcg_ctx->plugin_db;
> +    return db->size;
> +}
> +

FAILED: libqemu-aarch64-linux-user.a.p/plugins_api.c.o=20
cc -m64 -Ilibqemu-aarch64-linux-user.a.p -I. -I../.. -Itarget/arm -I../../t=
arget/arm -I../../common-user/host/x86_64 -I../../linux-user/include/host/x=
86_64 -I../../linux-user/include -Ilinux-user -I../../linux-user -Ilinux-us=
er/aarch64 -I../../linux-user/aarch64 -Iqapi -Itrace -Iui -Iui/shader -I/us=
r/include/capstone -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib=
-2.0/include -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3D=
gnu11 -O2 -g -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansi=
on-to-defined -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplici=
t-fallthrough=3D2 -Winit-self -Wmissing-format-attribute -Wmissing-prototyp=
es -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredund=
ant-decls -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla =
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-va=
lue -isystem /home/alex/lsrc/qemu.git/linux-headers -isystem linux-headers =
-iquote . -iquote /home/alex/lsrc/qemu.git -iquote /home/alex/lsrc/qemu.git=
/include -iquote /home/alex/lsrc/qemu.git/host/include/x86_64 -iquote /home=
/alex/lsrc/qemu.git/host/include/generic -iquote /home/alex/lsrc/qemu.git/t=
cg/i386 -pthread -mcx16 -msse2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LA=
RGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-=
init=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIE -isystem../../linux-head=
ers -isystemlinux-headers -DCOMPILING_PER_TARGET '-DCONFIG_TARGET=3D"aarch6=
4-linux-user-config-target.h"' -MD -MQ libqemu-aarch64-linux-user.a.p/plugi=
ns_api.c.o -MF libqemu-aarch64-linux-user.a.p/plugins_api.c.o.d -o libqemu-=
aarch64-linux-user.a.p/plugins_api.c.o -c ../../plugins/api.c
../../plugins/api.c: In function =E2=80=98qemu_plugin_tb_size=E2=80=99:
../../plugins/api.c:246:14: error: =E2=80=98DisasContextBase=E2=80=99 has n=
o member named =E2=80=98size=E2=80=99
  246 |     return db->size;
      |              ^~

But the general comment is this is an example of tying the plugin API
too deeply with the internals of the translator. Why does a plugin need
to know what is an implementation detail?

>  uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
>  {
>      const DisasContextBase *db =3D tcg_ctx->plugin_db;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

