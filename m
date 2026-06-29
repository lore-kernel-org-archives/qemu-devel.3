Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1635FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAic-0002FK-G1; Mon, 29 Jun 2026 08:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1weAhz-0000pi-GR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1weAhx-0000i8-PU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782734603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+/7KoDVPZZaADb2hRx7+lPrf05+orc1tOqncW6LS2E=;
 b=NS5dwU2IAMH7CJVN5ICGbwFbcSGGmeMpb9wlZAbzKvpziXhTct7o7Oks/n+LtyNfaebegJ
 W1lH2VsRvVqrHHVHL4IK+8BXZk888320VvEerpcy2F0EZQtxoVhGwsY9QGBVcYf2f77s7X
 rk2060StdBYOkY/5relsAVJ69Qtu4mw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-C5QGgVZgPbOqoL6vDfmzNg-1; Mon, 29 Jun 2026 08:03:22 -0400
X-MC-Unique: C5QGgVZgPbOqoL6vDfmzNg-1
X-Mimecast-MFC-AGG-ID: C5QGgVZgPbOqoL6vDfmzNg_1782734601
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso902490a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782734601; cv=none;
 d=google.com; s=arc-20260327;
 b=MiS7V56T2Sx5vsgni3tQJB7NxxegIrYnS7TrSNpYiwnyeyHaW7yoBfKGkLFwdGu0D8
 zdNHQNfbhwwEtaRZwq/oAAcKNiyCWYjiFDI8+wu+AUYSGK9yyo0Oyh8l57lJmf6aKb+W
 9VmlsegYvg72fdppvH/iP1sMN3qgUs09h673Nmu3Kr19sTP2JHc1f74gd1e6scg54wQP
 atCtwbnGVYly19Z5FvTM6ae7B4GffqKoaNEKUBC2MhJxLdY4EhDhaN0jZTm5HRcRhwlX
 M3nt5+m7Wf4DrTEqkc07jo1hLkZVKRvFuoag0yGx4bF8/QmDkw199CWhwVp/C4cNEXQM
 UpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d+/7KoDVPZZaADb2hRx7+lPrf05+orc1tOqncW6LS2E=;
 fh=RG7xCu/caEnr4j5ZoDIWqotdsOabLPr/b93leUKxILQ=;
 b=CXH3bmoedr9DimdYjygfatAwq8LfN9SddZKIpWvMLCnWrapYLsbSSt5tCh9a8tb2P1
 eF3YDcqrEyIeLf/q+EDUrGtvfpl88JAYIAwyWqSDTIOKNUlPkrBmaxWLFLgbmkauoF6b
 pLwj9qQ6kac+LM3lTChGSO3ICmloFUZU1eyGuLlTRIArqwy60jwP3nUdQVdv7nPHWgX/
 UHynXml0XEBZaARc7pBlKxko+u1ttfQ7QlDrLa3rBb9z9YfRFJZshhMfl/uux7oDwpNF
 pTQV26cG+EqYgTz00WDMGFu+CQly3BNZzUVLWyJH7xo03unH+e4uGc2i4cJKdyB2FVn2
 WGrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782734601; x=1783339401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+/7KoDVPZZaADb2hRx7+lPrf05+orc1tOqncW6LS2E=;
 b=ePKBe3fNbDs6ghlax+QyGmNO2pgbfdqBS2e6NodjM+2llqL/o0ODc//ZtaSYL9kS6h
 h7kxp0pMRRCK5jpzJoQL5N8c/HospZwbzD9NLdeO1hm7i/eqRepC7TmGDxc9W4hrscqk
 P72bqrBZnfb2IYN+BA0aZ2StcLdm0aSuL/fpb6NqIfiA0WCSWSAZSCeVouBmUzpv/Gk0
 3bAfW1M+uulMJ/04amyGIZrz1JIflZZkXBE+FwIY/2pOXl3UAy7Z+e6mtSLeXUA1ohrL
 RBK4OQ9qvxT6XRNt48I913ZCHenUDCXEngU4pEO4G0yXgaUVR7SwgaeGsJAZFJYUtlvF
 Ummw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734601; x=1783339401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+/7KoDVPZZaADb2hRx7+lPrf05+orc1tOqncW6LS2E=;
 b=Ocaz7NBOqt9cluqN2f6bDrTcZYdmqAA+XgGbatUtTCNEEVZKFng2Wxk6B5dTuL9PKe
 bLKihYJyLUunPxrXhhsob90gm2vTE1ohGGuEQK+5RuaiTa9ylIL/fzytTVKxrkrnwGZN
 obljdFzLVq/RAy8MA2bIQodnla1gPpVz0xd4n/t7yGErXHHwEQT9E3BCKqFqWu3oOg9/
 X46diEOxoxKT0+m9r28X55xaUC6bP40npZKlarQtpLBh2pwlWLRs/oQ55UguWM2N7GR1
 CrC9ZFHbjt//bH3gRlAQR8MNmz0uSmBfCw3AxeOXZTWmPt5qVkO7e+Op2cO+WynY+KuZ
 XjzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/39nTBmR+7H4BtiGZ6PxVllc5P6cd16mrDPdg/7K1AHn3IY1xmx8o6iZEIgX5jIKaDERdMRQNtWgAz@nongnu.org
X-Gm-Message-State: AOJu0YyyFZzhx6P0hoswcYHl2ux5or0+k0RZ9cQbmdPWri+++OCcnPP7
 rIYuNWNpNuYhqJ4LgJOGCfODxjUy+okuho27R2Qpa7zJm+xM4sKuIrV08CNy0zH8+leGTrCmkyC
 Vm75eaAEijmtB7aLdfXhIFs58ruOC8nNWAepFCYIrcHcW4cBatbDlCxYS4LaQEekXiVCU26woAQ
 8KmVC2mgnMCMJ97tyAGS0GnoyWqa4I9PE=
X-Gm-Gg: AfdE7cmo8Q/bt/kljvMaNpSynUlZONTTVQqaTLUJwXg9rPkLU4zMtwSURe6BXCsoJKH
 Z9ZwVycDKAIUFKNUC25YFhaMgAwNB1zleGNqO6w+ApAejKqfpR7JGkDXpdT5wun2GLyOBSEQSzO
 +KJrLpqI8+aFFSu79WOGJK5hgHmjTWl6jSyM6a6BqYb47IENZ4fNcJnmMsRCwcmLikRKfV39w+T
 1x7o6ixkLGkVnhPWsPyN63tjz9dPRQnpDuZRr1A0qncivdZJNA8lB4yDZ6U7i+7kURvmrDDYIXd
 zHqpYaJ+62tR
X-Received: by 2002:a05:6a21:48a:b0:39c:cdb:5d81 with SMTP id
 adf61e73a8af0-3bd4ae81cd3mr15753851637.32.1782734600867; 
 Mon, 29 Jun 2026 05:03:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:48a:b0:39c:cdb:5d81 with SMTP id
 adf61e73a8af0-3bd4ae81cd3mr15753816637.32.1782734600345; Mon, 29 Jun 2026
 05:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260629114646.288664-1-yujun@kylinos.cn>
In-Reply-To: <20260629114646.288664-1-yujun@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Jun 2026 16:03:08 +0400
X-Gm-Features: AVVi8Cf7hA7QMU6JB9LdS30i9IUbK12F9qnvxgWgSXYctNgnFGo6jNV924xUmB4
Message-ID: <CAMxuvax=G78MALxpqUOdozabj=69H=LNZivBzwFo2_sEHrv0bA@mail.gmail.com>
Subject: Re: [PATCH] dump: fix misleading VMCOREINFO phys_base parse error
To: yujun <yujun@kylinos.cn>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 29, 2026 at 3:52=E2=80=AFPM yujun <yujun@kylinos.cn> wrote:
>
> When qemu_strtou64() fails on the value after NUMBER(phys_base)=3D or
> NUMBER(PHYS_OFFSET)=3D, report a parse failure and include the malformed
> value.  The previous message suggested the field name itself could not
> be read.
>
> Fixes: d9feb51772 ("dump: update phys_base header field based on VMCOREIN=
FO content")
> Signed-off-by: yujun <yujun@kylinos.cn>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/dump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index eb2ee1c10d..f69bc2d138 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1771,7 +1771,8 @@ static void vmcoreinfo_update_phys_base(DumpState *=
s)
>          if (prefix && g_str_has_prefix(lines[i], prefix)) {
>              if (qemu_strtou64(lines[i] + strlen(prefix), NULL, 16,
>                                &phys_base) < 0) {
> -                warn_report("Failed to read %s", prefix);
> +                warn_report("failed to parse %s in VMCOREINFO: '%s'",
> +                            prefix, lines[i] + strlen(prefix));
>              } else {
>                  s->dump_info.phys_base =3D phys_base;
>              }
> --
> 2.25.1
>


