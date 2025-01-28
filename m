Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DADC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tchYu-0006IR-PS; Tue, 28 Jan 2025 04:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tchYs-0006FC-RA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:07:11 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tchYq-00085a-J3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:07:09 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso35617355e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 01:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738055226; x=1738660026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZq/ubRHzoR6krJhB/P65pDUglY/XsXX6giT21hiuyg=;
 b=jUuLGXf+N2p3OLiedTq1gpapg3TdZda8gVHRcbQf9R8Nj2EG4I4JCCX4KR0y2WBYbu
 NaTH/esMPn20P67jOaWCyxpEFt+0C9B1npIkKRI8EpY9oEVuKqPA8TWbZq8QpbIKTAFM
 7oWTkUNDocNp7bg265ftiDdm6HwEWpHrMfPUwv+zuz44oOP6dnW0WqmWIUvMVnzxzEar
 R9OAFC0XGK1iF2i9w/RuFCzeNF9xXXp1YFxcPqR7BfPRbWQDbI5xp2HfSZrdvY3eFLhD
 cHLKsuGHuqZGQ1jyTvL11oCZzjnKG+3MdA2ZNZfkC5CTh5vspg6uYvGj2/nGirDipALz
 1++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738055226; x=1738660026;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RZq/ubRHzoR6krJhB/P65pDUglY/XsXX6giT21hiuyg=;
 b=MGH8hZmGd52I5zohJe62+rSR8Re1zvRaJn3rOU57uvItdWvZKVQIByt26+ttnbJ1Zg
 cf655r2oR3w9PGNNp/+vM8n27iHWhilbxN5Z/Bntjolgp3hEOLBnuAqd02lxIniCOY1S
 sJ7VXPl5FGkp0YGiz87SNYx0spDHEFcpcZ9gRr9XsykfONtxA85wPqNZbl0Zxgad5O8Y
 PPQAQHmf7sa9eSYpeYzzMIcH8ZzqDcNAxa9+K/EuXyo1eaCWyFbfWG1uLmSM8gAmSy01
 Nh+rdagKGtv0nVMpOcdEytO3N2DM3lyye3wTkDj3l3NIDoYJz67AvoU32yWm1eT9UIOS
 MtPg==
X-Gm-Message-State: AOJu0YzbM6yW4fBxp5PZY1HkzQoCh3Tib3gdEcr5oF5GNlmaUIpSgrbJ
 qts/YEBgfWvlUSktxjmHaeZZmf2wVM8neivi8EMEVOrpXNaWDY+Je7uw67ku8uI=
X-Gm-Gg: ASbGncvfMOgz8tvU/8JHhy8bFrrNKfJgyFlosKzSrFZm47Fh8jf4jN0nnjtfuwVhc+B
 lwnVgwXG9vnmdULGP6VFi0dMNPcNVy0lvm3VqFO3XXQfvh3rrDayXmfQRidkpGzgu+L998DRalY
 TsuPdc9os0jzXtQria3kl7V0OZZw0qFouRKig6UCBIugvLKs11HsDEux35KqC/iH/q3z7pjk5TD
 ggzCaaRn/V54vnnkx8ZQmrNY4A0zn7+N9FrnFE3PGNmite5i4QgHHkUjHNrTiqltvZ6ilj5EF8T
 97TpKmxD3q+fb2OiTWaZ/6E/
X-Google-Smtp-Source: AGHT+IFYP+vf+Q43Adl9JnqJXMpwr7nNiw/r64fkGk+oKLCzeRcxdt2psu7lIDVcJOXVZD/7SKuw/g==
X-Received: by 2002:a05:600c:4589:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-438913ed0b7mr440156125e9.14.1738055226251; 
 Tue, 28 Jan 2025 01:07:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48574csm163256835e9.9.2025.01.28.01.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 01:07:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B40B25F8D1;
 Tue, 28 Jan 2025 09:07:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Luke Craig <lacraig3@gmail.com>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 1/2] plugin: extend API with
 qemu_plugin_tb_get_insn_by_vaddr
In-Reply-To: <20250127201734.1769540-2-lacraig3@gmail.com> (Luke Craig's
 message of "Mon, 27 Jan 2025 15:17:33 -0500")
References: <20250127201734.1769540-1-lacraig3@gmail.com>
 <20250127201734.1769540-2-lacraig3@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 28 Jan 2025 09:07:04 +0000
Message-ID: <87jzaf2ton.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
>  include/qemu/qemu-plugin.h | 11 +++++++++++
>  plugins/api.c              | 13 +++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 3a850aa216..a1c478c54f 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -500,6 +500,17 @@ QEMU_PLUGIN_API
>  struct qemu_plugin_insn *
>  qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
>=20=20
> +/**
> + * qemu_plugin_tb_get_insn_by_vaddr() - lookup handle for instruction by=
 vaddr
> + * @tb: opaque handle to TB passed to callback
> + * @vaddr: virtual address of instruction
> + *
> + * Returns: opaque handle to instruction
> + */
> +QEMU_PLUGIN_API
> +struct qemu_plugin_insn *
> +qemu_plugin_tb_get_insn_by_vaddr(const struct qemu_plugin_tb *tb, uint64=
_t vaddr);
> +
>  /**
>   * qemu_plugin_insn_data() - copy instruction data
>   * @insn: opaque instruction handle from qemu_plugin_tb_get_insn()
> diff --git a/plugins/api.c b/plugins/api.c
> index 4110cfaa23..7ff5e1c1bd 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -258,6 +258,19 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb =
*tb, size_t idx)
>      return insn;
>  }
>=20=20
> +struct qemu_plugin_insn *
> +qemu_plugin_tb_get_insn_by_vaddr(const struct qemu_plugin_tb *tb, uint64=
_t vaddr)
> +{
> +    struct qemu_plugin_insn *insn;
> +    for (size_t i =3D 0; i < tb->n; i++){
> +        insn =3D g_ptr_array_index(tb->insns, idx);
> +        if (insn !=3D NULL && insn->vaddr =3D=3D vaddr){
> +            return insn;
> +        }
> +    }
> +    return NULL;
> +}
> +

I don't have any fundamental objection to this. I would prefer it if the
new helper was used by either one of the test or contrib plugins to
ensure we don't bitrot it.

>  /*
>   * Instruction information
>   *

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

