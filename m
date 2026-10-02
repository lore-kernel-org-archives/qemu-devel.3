Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BE3CA5FCE
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 03:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCTfT-0004s7-RN; Thu, 01 Oct 2026 23:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCTfS-0004rm-Jz
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 23:10:38 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCTfR-0004No-63
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 23:10:38 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a8038a9f10so9911609a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 20:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790910635; cv=none;
 d=google.com; s=arc-20260327;
 b=Zudn41KPgxqG2clN6oiY9I61HJ+nt1dm+KJbeZ7PFUFYT86IA6F6SxzCMKypzciDpl
 EWEifHjJDL6dT86OGgwulvG/0/dNHpDMPPzca350wwMi9BD1PcGG6zQsRsoK308rqGfV
 RSbAln4l5RoLXxpXbr7y2WfDRmxNQxLtyxOSXvBP+rDTZ6TJyxJF4H5fh3HREVcRLVhx
 DwC6QDDdbd8oZ0tV9ELsUTWBqs4T7zWfqhfgyPjC/Bv8ddG1iHoc9ZbKp9FE+zixds56
 fhymnEzdWmRZa3MZS68m4mob2pQyuTWI9FUS2I1KzRtaSZvwVp6Qw6gDzfRgWPaaYULE
 XNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=O2qwL9HHfLSa8iidf6iXkOt32mrRAdwATltII/NaBwI=;
 fh=3bi/XHrCCnMCgy5hotJFZ1RYRGIsl3APZaDMWQAcg4o=;
 b=Z269JbvIO0yI/yFabpD9Vh3Ugr30VZzl17k/dYxMqXG3IWaKKwKR5BPECGfMiYAUm+
 TZBQqYV4X28y2r3obAOTctreXu4v232NohuocM9RQWkehfeRfOnpLs9cAyXtB0SZ9J9X
 umyqPUxCj+cpzRaMSkFcDgP3aBtUUOnnS4wm99YuOwNXpEUPyrbZaPO1dwPGc5wz9rYq
 J26P5J7bEgzUtdS4MtS+3hrLjxVlmkS38AHp/PVjWgyUGT/wqfE2h7B7SK0vqAEfTZmw
 0LSTFOsMuVIjgVswDmZnbodBnXPJXfGjdNUVTsGeEwIJ13YknxQUf0SvE7n4obe6GZgV
 mXWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790910635; x=1791515435; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O2qwL9HHfLSa8iidf6iXkOt32mrRAdwATltII/NaBwI=;
 b=hT2oSSR96rJIknSbB8YtZeMnMivA3E1IoesMW3S3evXZhD0IC753Ex7rNUe59YY5Z1
 WKQCkFomIjXwVV2gQ4kE65GhyFPvjVyVT3o9+tgI5WTYg0UYFTs6VtsiXoikfNHsaass
 4P9AeWtHH2aQjdE4R727f8VoCxlvrecHxcxRVNnQ0vSX9gIIhhevYwAJrvLoLHlfyGdY
 O9EKDdc9pATWcmrDtpb/6x6urD1L4uLeM1TTuMqnFSdS4HFcmcfttFQQnPbSrxoT1XA7
 y3GJBpf9CTacXmNASBk8ZYAHLv9Nu/NWaicV8IDv/WmSZVTdnVyYFaFtnt7R1xnd2Fsf
 81rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790910635; x=1791515435;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O2qwL9HHfLSa8iidf6iXkOt32mrRAdwATltII/NaBwI=;
 b=lVvwqOIP5T0e/8BobEngdn0XMy1XiS99yHrzQ8PW1PSipTBJwu99JrjRYFVjcI0pcb
 9O2PK5PQwe15RKN/nu3rHco1/063UZzvmlp6uXBHrWoLuM/aagtItvDjmWcjttasmrYz
 U5wB62L2WlnkAF8oZiCpM4PkjXfrhI9/aTdRANqkKRBldjVPz3ImD2AHLDIFwoCQrzew
 3/ylUpaE33thmhaXMlMdC5o5bVOv7H3TFT2idjzV+nEX3vxcp34iPfOQJVwSqf4+0GEb
 qNjIacAdvYL+m1ktClgcDbq46BVVrs9hO1hTVCScaWg6wOgigc2bxN5DceMtsjgR1Eau
 yhGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFxiRNA1kr2hR1EnZ53DZ8cgiZlu4++cWP4DkFHVEwPCvDEa6ZDGjgAa40puX90ARzpM/yYGuCPzC0@nongnu.org
X-Gm-Message-State: AFq9FYKxJJSigQueGXjZ/adyI/ldeLZzZ4S7sTt+kHlAkSyB7eQzsJzT
 G/aS1IR3tp8XbKNE3bOIB3gIDTEimbfSJmPdtKsRtf4J9AVu0F2jNrtTyfKY1qJaj9jX03l7za/
 3Dxq//BBJqPiy87xT55xFLpXetlrUYY8=
X-Gm-Gg: AYBFou0S6wchXa070OteebAVp6nT0z2WP+HBBuMZqBVoD3CasNykVJ5/sVvwXC3R5Z8
 DthnuZSKIyGBBrABKKEuSUQiqpUdVw5jQfMfiSm0ENIylfEpt/NaSwB8czM4ZCz96UJkyy1VYwV
 R0Vf+FxH1Ff4WIh6JKqCi1I/rIYLPFw34gl268OZBy5aOzAmaHph548dTTxQ2b+mtUmEq3TFPJ8
 fX5Chiyqp9R8DihXo8jxBglLHe5BYn2LYcWh9GPPmnr5J3FyNYlbOOlWhm4ZSq/xiz10zvfYl3J
 /HLnu+JTu5kzgRIRwaBNt5loAWKOgS3DQS1PfeHqURqB4Hn+bGGppElEe6gQ/unflQ==
X-Received: by 2002:a05:6402:241a:b0:6ab:81e:e827 with SMTP id
 4fb4d7f45d1cf-6af9e342c7amr588658a12.43.1790910635387; Thu, 01 Oct 2026
 20:10:35 -0700 (PDT)
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
Date: Fri, 2 Oct 2026 11:10:23 +0800
X-Gm-Features: AclHuK-V0xU1FhvPsvL3Y6lfOZX2d6Sg1XJ8ZXrABF_10hAEPt_ryix_uYLfPvs
Message-ID: <CAE2XoE8mmz9jjhEgJUYZ3Symk==RJTSO6uVy_2haxcuFkunmHA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 2, 2026 at 2:56=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> So, for existing binary: -M virt works as before.
>
> For new multi binary:
> $ qemu-system -M virt:
> Multiple machines were found, select one among:
> - aarch64-virt
> - riscv64-virt


This is what I implemented:
 ./qemu-system -M virt
qemu-system: unsupported machine type: "virt" for target "none"
Available for targets: aarch64, arm


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

