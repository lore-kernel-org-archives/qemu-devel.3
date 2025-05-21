Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046C7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 17:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHn67-0003vD-5d; Wed, 21 May 2025 13:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uHn64-0003ub-C7
 for qemu-devel@nongnu.org; Wed, 21 May 2025 13:19:16 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uHn60-0002Jm-OR
 for qemu-devel@nongnu.org; Wed, 21 May 2025 13:19:15 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso10486542a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747847949; x=1748452749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4y7uRtsmf6DLamxULcTn2mfCWgYY2Qz7NE4/ug0gbw=;
 b=x8sM5WJ1BsPbEMIpRDcGjbQTuZ8ENakOtzv/g5ve/YpA4m5P9T6VVb8pP1QVUhVSA0
 80m4x7vVTjtldFFm4nUmv13O0A2R/Y0BzWL0IiNpqyeBUb4hZ8+5SBau54Na2kqYlIBs
 35yhK4Ohh2Aqri63i7/A3DlHlktayI1YZQ/XG5tX6TVGevGCzTE4q+o2OaDmRqz+wsz5
 6llnD1NPiz985kBneK5MKytym++ywtshKow7038akY7uRPT6sauH/LR4DQbRqtU79niv
 RInoNXemTcGzO+ZdYZzi3xPnXXmUZHhTf7gIKb4GYObBv8Oe4Y4+0mVlRT6w1fXqQvGq
 AMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747847949; x=1748452749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4y7uRtsmf6DLamxULcTn2mfCWgYY2Qz7NE4/ug0gbw=;
 b=ULq7/f5fBNv/wV3WcNmuTlX+5tvzLDg7fX02U199qwoNi35DDqxq53UZkKK+ft4Ogq
 yfhkSCeefkJraccf0vtC1qe2dVkIlaf95RMOw8fatfGEIEVH1FcRm5rtJ77vlHn+/rqa
 Yea3ifoqmF0Wp3dhaF5hPO+9tq3FcLNouEL2ZzILBPGb7HttAB6PVQ88pQqaYT+QNZT4
 AIbjuz2IrQgPBmQEtrENt/a1Y5cY02GtX6obW6QbYTbiWNe3NJv4Rvxz0bi23ESPjoDV
 6/ZDrtHT2H2bL54r68Heve7jIa9Ec5NL05IYWn3M2DkAe03K/9df1z0YOCd22lB/SjWQ
 QkuQ==
X-Gm-Message-State: AOJu0YwQO/xcbmtEQmNkFSSnoMCisvnpzkQNd50Bzfk+AhCMD7Uu0fv8
 ZW0bYqzNZdYcqm1bGPI4fXme8LFse6dCacpop3aMTUxyc6+hRX5W8beYRfclqZ3pamKq+Aw5T7K
 AfN1KeXjzaIkLVTITp8Rz4+AhZFLF7FiGdtsHpFnRrA==
X-Gm-Gg: ASbGncvO+YbQyA1WT9Qax4YWOU4F6Q+6joDXl5EiNb0GyMfww79PSCNs4LZX8I+aBZH
 YC0ycNVSd4veDq+uZA4Lq5kFFbvlcX+XBLJ9ZQyzGvvFcgFke4zmGInV4YWFs3sjQFzxpM/gLRA
 a6jxAdgvVZWaoo+44013W1gCj11aGA
X-Google-Smtp-Source: AGHT+IG7I6Q9jQC7dWE/bhRxm10uXO23lXXa7keEgsZybUBARz51QU9H+D3WFcdT4Me6jMWoETzZYQcr7VRn3NK24wg=
X-Received: by 2002:a05:6402:3547:b0:601:ef7e:fb59 with SMTP id
 4fb4d7f45d1cf-601ef7efe9dmr9587956a12.12.1747847948915; Wed, 21 May 2025
 10:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250519171004.352636-1-berrange@redhat.com>
 <aC2XX9jqmCRnSnQV@redhat.com>
In-Reply-To: <aC2XX9jqmCRnSnQV@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 21 May 2025 20:18:42 +0300
X-Gm-Features: AX0GCFsvBBSsqVwyDu7rfggTKrPLJ-YMZfwqApRgagsw0b9KVxuSLApyjAhZig4
Message-ID: <CAAjaMXZ_s-szw11si21ebqbpaX_=4Me4ZDhaNdTJuiQST5J_-Q@mail.gmail.com>
Subject: Re: [PATCH v5 10/9] scripts/checkpatch.pl: mandate SPDX tag for Rust
 src files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, May 21, 2025 at 12:06=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 17b8db40ad..c0b36a85cd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1499,7 +1499,7 @@ sub process_end_of_file {
>         if ($fileinfo->{action} eq "new" &&
>             !exists $fileinfo->{facts}->{sawspdx}) {
>                 if ($fileinfo->{filenew} =3D~
> -                   /(\.(c|h|py|pl|sh|json|inc)|Makefile.*)$/) {
> +                   /(\.(c|h|py|pl|sh|json|inc|rs)|Makefile.*)$/) {
>                         # source code files MUST have SPDX license declar=
ed
>                         ERROR("New file '" . $fileinfo->{filenew} .
>                               "' requires 'SPDX-License-Identifier'");
> --
> 2.49.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

