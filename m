Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D11D3EE64
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viud3-0004N6-3v; Thu, 22 Jan 2026 08:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1viucm-0004FM-PD
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:21:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1viuck-0007Du-TR
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769088080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kUV4rCKnBi2lpJKIqkTwfs8IRe11j7i2llKyzWWeBw=;
 b=KsX8e6sqhrjRxapNXobfEffGktpns8LpvGpU/UsFCWhMMaFqIwtsKxCVpMgKnk3jcRRbUs
 CHquxifLE+imHGkIBbX4fEFVXFpZcOY/Jk50zEYNv3FZCOUZdXRqUxCroS+1AtqDowqOdH
 YseP2I3etuG7DxJRQS2bQMeSMD+WRBw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-vJGb-RFbNRGwPURmZ1hWjw-1; Thu, 22 Jan 2026 08:21:19 -0500
X-MC-Unique: vJGb-RFbNRGwPURmZ1hWjw-1
X-Mimecast-MFC-AGG-ID: vJGb-RFbNRGwPURmZ1hWjw_1769088078
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435ab907109so345994f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 05:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769088078; cv=none;
 d=google.com; s=arc-20240605;
 b=XEEsSrFSFb79+BoCA4Utv99NCIdyNWLWGrayT8lY0vAm2tNkISA5EBuVIyScsTqRTk
 rEw/5RIxR5BR2c/CjLh5CivT0epbUGfP/BTbos1mBypBfyYb/adTy7GmrLVxuyUag42G
 v66W0peqG5dG7pLrLSwfrS28tp1dE0IPGLQYg5cjr/t+puacZnexjfn8PtVLoFqMXcDE
 LHcM9xFR7bD6qjMtMPKmKHFX2jofsi1jJj0lmj1psxDMqYb1jnCZGE/RdUqBHoGCT0qt
 6kmx0EzjOqEBH6BF9EPCgdPbGKe+B72FeyXhdKcs6NZnaHQD9ZE6cuWVn4fhlD/TGM1/
 uNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0kUV4rCKnBi2lpJKIqkTwfs8IRe11j7i2llKyzWWeBw=;
 fh=ToTffMuwnwZHKaF/Tl/6PmsBkVZ/Gonnv+9Gz9JXbJQ=;
 b=CAJiGxjvZPY+OD2hYdVSC1aXtluTFrI5icgZXbUhTtSPYuQDxkTs9NEzJ4UTp0C0ih
 9XOW+jWWVyes258XGtfAeFtPmNnzecbKKo1zvdo9c7HapK9/4+T9c9/j8mi/284Wjyc+
 QYnBdiN6sENJnqpFgGemLQsMBmp64032HzA3rFREw/SU0nFEeJamLfYRhLisKcknUtfA
 QEUGz0VJr9iBdKk+W1WeUKHWJ8xqKSz/p0LgpPOLHx79O9hkxhVQeRcU1Di5C/UGQGQB
 O45A1Q3VpEUfOLgi/8swvc/oPCJaCIG006OQkoNOTpvRwDFAZsQ21OjAIIb3TB/AXUzo
 Nk4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769088078; x=1769692878; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kUV4rCKnBi2lpJKIqkTwfs8IRe11j7i2llKyzWWeBw=;
 b=KCdzQzgrVxGW6meU6lIfAEgGrMOyR0QS8wfluU3o+13cXLLLciyLuqgsV5jwkcM9Pp
 tZrn9hLkUEFdasjPhMMPniZOHcWpzFpBppt6GlltWaXnWRK5F5wkUUptZLi4l15mNBk/
 fOCjKJu+oXdCYs3Q82A+PHd6B2BUbE4CpuGRhhf2tWJ2T+vZJIaljC9gvFWjTnssM8rp
 CsMMizbtehUIzrTv+jN/0TwWPadKtEcu8Hex2Ubk6mQKZJdJ4jmeAhrwNvLKMyFGBrPF
 mgzklji//tRTvKTndBgb6zD9FF8I7bfo7zA3S26zB+wW9MZjqmFH7mDpP8hhgI2NARJO
 Fi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769088078; x=1769692878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0kUV4rCKnBi2lpJKIqkTwfs8IRe11j7i2llKyzWWeBw=;
 b=lMY3ZNLkjk1CtHreOc6u6Wvb7Lb0LVfvvnaA4NCbUf9Z2Y11TPw1PYAXq4bDqe2y81
 70herzV+uXfKbTAFWu37pKSOGRop4sKF6BuGhbsQtERoWFuFEc8N2qeV7lmrFv4OtT1J
 +gxmAIWOTCoQ/Fp9VUcCzmOyAr7X+v2vSNF86jbRbeOykCIIBKbUtSOlTympf1tovqc9
 C+4XiDtYE8iKCPB6fhOzG9Q0blECsBxs+HlaoK549jRhd/32aFkA13SfRYfYp4cVvrLe
 IY8Vo+D0W3h7cAh1I+UgSLhjAo0Mk1t4vx9IoS1o7N8PCc0tVXGERe8B4hkHaUBX4tj5
 RPKA==
X-Gm-Message-State: AOJu0YwEAOiYvh09Su9sEgn/evrrvQ5OtjgGSMk6M3YBbqcvInAROp+/
 yWyba7aOWrAurrZj4d3Ja8hZ5ig+qyRUg66gfHlbf/Davm8G8zQxRrik11YLBgDgF0pK+BTWgRM
 mkaqEU31IA6U6QmJhhIek5kmihl3IhVTaMCilANzmD4C+LyZh7Ep9KqmAcl6944BRmeijDqSl15
 jrpYzFC018ee5ehQO61Ujx7JiK7uXWN+Y=
X-Gm-Gg: AZuq6aJvlNfnnDQLRF7U2RCLwnHksVh7gU6HtVIzto3iKARjAxT8o8Mga2FM3eTh4TC
 xH275l2gUp/zttQOmGutuO/54m9XmXWu5wzageRhiHU/xVJuXXjxv+J0qWUIGou83E3/d7Uif4m
 uDs8h9pUKztuqJQZMpqokIWVrExtHXiC6yXFGrLQJg6FC/isHV7VuqtlxEI0Hajn82tlF+MyhBr
 UFaitMdvppaMilDFjiHPrlQCk+BMS2BIftz5LcfD6xuRtqGgcEtSNXdzaBYsGB+NI9ijA==
X-Received: by 2002:a5d:64c3:0:b0:42b:3131:5437 with SMTP id
 ffacd0b85a97d-43569bc17f6mr27926743f8f.34.1769088078303; 
 Thu, 22 Jan 2026 05:21:18 -0800 (PST)
X-Received: by 2002:a5d:64c3:0:b0:42b:3131:5437 with SMTP id
 ffacd0b85a97d-43569bc17f6mr27926712f8f.34.1769088077955; Thu, 22 Jan 2026
 05:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227094759.35658-7-pbonzini@redhat.com>
 <CAFEAcA8fjzx49c=Xe37PtMNCbN22h2UQ48kzPgWVYx6jBBXYog@mail.gmail.com>
In-Reply-To: <CAFEAcA8fjzx49c=Xe37PtMNCbN22h2UQ48kzPgWVYx6jBBXYog@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Jan 2026 14:21:06 +0100
X-Gm-Features: AZwV_QiVq9ws3I7Oovn55qsaH14YXNnD-nPRRnQjLIillPyVKtmibovtui8kOPM
Message-ID: <CABgObfZFd6xHt++XJHbCPwZU0x5chu8SYE0OFVbs_pk5McAJ9Q@mail.gmail.com>
Subject: Re: [PULL 081/153] i386/cpu: Fix supervisor xstate initialization
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Farrah Chen <farrah.chen@intel.com>, Zide Chen <zide.chen@intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 22, 2026 at 2:16=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> >          supported_xcr0 =3D
> > -            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_=
XSAVE_XCR0_HI) << 32) |
> > +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_H=
I) << 32 |
> >              x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_L=
O);
> > +        supported_xss =3D
> > +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_HI=
) << 32 |
> > +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_LO=
);
>
> x86_cpu_get_supported_feature_word() returns a 64 bit value
> which may have bits set in the top half (notably it returns
> ~0 for some cases), but the shift by 32 throws away those
> top bits, so Coverity complains about a possible overflow.
>
> Is this an actual problem, or a "can't-happen" false positive?

These four are 32-bit, indeed.

Paolo


