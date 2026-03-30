Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A63FF493F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w74H2-00023q-N6; Mon, 30 Mar 2026 00:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w74H1-00023F-Ie
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 00:30:47 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w74Gz-0005Yk-OO
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 00:30:47 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b97ba4c2be2so523251566b.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 21:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774845044; cv=none;
 d=google.com; s=arc-20240605;
 b=LnXUZdPDDuRT5dMPSNjc2L7bqVTsmDjkSHrVjpLT6W8BiYBPPFZq5d3sGj7/iyevZo
 v2pwkc6U/1XV4HKAwYnY8ra4Yk5Z+3EA6tZzwtga5CVGGtJOq0mONJ4IVSt4aFCc7mdC
 IE+0/esCNXjLZGGoOPelU456TV7LttSaSaQ1ph+pjevXx/uzCwJNJqpCWcuC8yMuXENl
 pajqfbUlQfH1C7BCBvGskBeoxBrionG4476bZHLh0Gy5hAZNObHxZMQCaFI+m8dyi+JM
 N1KGgSg1901obkhOTHTSmlwbjtGyvGbvDsohopneu6mdxVdP3R5jfKbkzbg3Wq4OlXay
 jDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BPjxy6libzJadxuLmZKM8vnCdotc78+FZWvRkopsIGg=;
 fh=tIpPNBugPhpXlvOshQm6zzorfmeWc9PliVxbC2ced/g=;
 b=Dqn3StulWEWEbj2PQddiROJZkdRA6Dr7hJg8bdQJj2O/kKffYWGjtsr5BOuvmUmjxc
 mwqAxsETzUTUSsUqD7nxsb6gIAC8AwXdFWHbislZkeqOwW2Ju2AZ7ZWyiFR5SPpiHJwZ
 zzpztc7QnP6AosMkq6fxU+q+8i3mna0+eqfrPv5Vwty/duDx482fxgnr4a2fYwv5A1m7
 n41A661zFW9qiTWE7S61uf/I24qseFcJBPpChaGV9ZTOTrU/TeFFLtUjrhu/08OqWHNx
 Xjulqj+dtxEQd1HGGRGrCJy23Y3h0OB1wbIFO04fYkuhu+HmqVxLdqxMKgi2GwKlg2tG
 hXsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774845044; x=1775449844; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPjxy6libzJadxuLmZKM8vnCdotc78+FZWvRkopsIGg=;
 b=N58ti/xZldcUBk60NO1PWTtCqqjnamU8SThcRpeGBvufjqlWTRZPXbpu3/r8E9LqzH
 70oZIzvsK4H2YdwsF+fGKmHQljiq3+3rEacIh9A64XFLx0Dr0I79svvinFYqiCVRnwbA
 TxdT9yDKfb5bVz014QvAb3WQjIUxJB4O7pCK77sH+Fln0afMgrtgCjm0gVhfBkeEQw4V
 B8pxOCB5MG0HEpt/7XsSFXqFCNKRcfwUtvft9bjEhZp6KRVytrf1d6v6QcVvVXhEiHMf
 PhGW1/AgOkuavcw5zA0XG33u/r3tdasTxorOEOihtn/+r61r1isoERq/x/hUJ8oDG3ig
 PweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774845044; x=1775449844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BPjxy6libzJadxuLmZKM8vnCdotc78+FZWvRkopsIGg=;
 b=RVksn0a6I8OlhJefGKcTAAjbDbomnZGybJpnFRdDj56uEd5Mp91R5sieqgBQjh70rO
 cfmi9qzLNeo4n7S++3jn/wofh6s8MkYu3n0PQb3T5yS3sBrtu75ld17IMjGqcA+UMwQq
 I4Z1lNoI85U9CM8RSLYRKfPXpWmUI1jZUNeO3os4RBqluVSHE+Z6AcBHNQWuTxe0NPCr
 2Gx0Klr8yvlrJ9oeGiqyHbAFfMot22pg8TRc9HziNbQFaD3U4tdsVEzd+QZ+X0vqP15v
 SV5A0xpFWJ9MjqEr5h0XwcQ0jk81QobRhU+s3IpB0zzQZZJKfZ32ZjXHvI17JOTcNqD2
 DoWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVVrhkJpKvh6H/FWdbvgC4ZZzvLkmEPC/uG+K9u7bWsOyJ1QlNB3pz++vXj+53gKRwV1heDUyW89pN@nongnu.org
X-Gm-Message-State: AOJu0Yxdp9F7mcSC45W/18yaucOHciy6RMz1oS3Qnwb6sNzDcmhB3Ca+
 bwT4q3Fp+79Y9Zen2vG4Ajs5jaoqojzlDSkSxNRxqjkLvPi5LexXEmdxrKdo5lb/FHwGByr1Fas
 zirC6GawtPgzqoJrJU4EFmqvl4ukL0h0=
X-Gm-Gg: ATEYQzzVL/QkP19LzjhoIfCLGunfpKaCS3Cx75mVuhfphvxNRgSzIV4yZDV3ezQ4Ktk
 Za71dcm4dsY5FhBL/tl+W2QPhKHpHpuOO5zvzEDoTi2fRd+H+WriZZgfUaYX/zoa0iMVs6Lb9qn
 C05Q2ulkU7un4qxNLv4mn3+p0OL8kxQK5OIIYaAquO+2TFog8RKUhi8s/w7xT1oAUEwGalm9BNz
 V8lnef9oJ+OTKhTU8ucdJjLDi3O50qaPGVEJsgZxzoxHtuoAne4dvaBGWakDfiD337+897ozNxG
 3ApHY+E31idU2zVY/G+USetzHkYC3FnF0u+ymg==
X-Received: by 2002:a17:907:846:b0:b98:51d6:883b with SMTP id
 a640c23a62f3a-b9b502bee4bmr757822466b.4.1774845043511; Sun, 29 Mar 2026
 21:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-8-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-8-kkostiuk@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Mar 2026 14:30:17 +1000
X-Gm-Features: AQROBzCyc19tRu5zAga141IylI9K_Dcr-ZY9WcxhtTTde6AyEq3ClpnQjXi3SG4
Message-ID: <CAKmqyKOG3Aw=NPSTXKJj5QHwFzypRCr4Ra6A3FZBf7WrYEXPhw@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] target/riscv: Use glib2 instead of
 strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 27, 2026 at 11:46=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redha=
t.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/monitor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index a9d3111444..bca04a7580 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -303,7 +303,7 @@ static bool reg_is_vreg(const char *name)
>      }
>
>      for (int i =3D 0; i < 32; i++) {
> -        if (strcasecmp(name, riscv_rvv_regnames[i]) =3D=3D 0) {
> +        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) =3D=3D 0) {
>              return true;
>          }
>      }
> @@ -358,7 +358,7 @@ int target_get_monitor_def(CPUState *cs, const char *=
name, uint64_t *pval)
>              continue;
>          }
>
> -        if (strcasecmp(csr_ops[csrno].name, name) !=3D 0) {
> +        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) !=3D 0) {
>              continue;
>          }
>
> --
> 2.52.0
>
>

