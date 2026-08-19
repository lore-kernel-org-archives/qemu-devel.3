Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74704C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhW7-0003k5-Oj; Wed, 19 Aug 2026 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwhW5-0003j8-Si
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:43:45 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwhW4-0006Es-Fc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:43:45 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-ca80d708489so661080a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150623; cv=none;
 d=google.com; s=arc-20260327;
 b=ajP49XepasAtZ5mikwUbxD2oy7a90kKU/lHt4AmAvbtex4UYfYeU9jm9ddw/PvVH/8
 v7Jkdx0GeXVsM62hPRqZ43kiQz7QfNZM4OAgwtqMs9esIm7fAbKtREOwWLzkzNRpsL1B
 oFUWe0gcPgAJi/SyhecvAk33/Y7OmzRrmIXlTthFI7eGsOH8lDhFwOYfjsMkx4oIsipI
 tpyhHRKs/RgdxQmwo4RgzmSn78BuYepDl5XkZRdCho3dlv/YThYzawvyiIzLK92rYX5a
 Ho+ASVaMSKSRCU+GlABNDFxl4tjnZHUxdmG1JRY9mCJveiYMpjGqzKkDcpD6n1rjvyWE
 OpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RaCfQFebjYCn2S66Pq0NvkgKTMBfSiwnMigGYE1IGd0=;
 fh=8+kZWnBheeSXTKl6QWcm6S/i6/Oj1UUtjqopUkSvUms=;
 b=ep+3EygbU8W0Dt0aQM+nOrgVuKL/Li26Ba++NipahDJiB5hbffYNnKti8AVqN3EqPK
 O9bblvVooS5DKqL6TPYAvzv9MyJAUXXmpJfdc+NPlZL2F1IjqLxp3whQEMYPB46Ah7sC
 2eVnydbpDJbt7ZNzZOnMombfboAVYvr2qt+u0OktCE6kpMHEl4tTCys/nBYF4nONKjcU
 jsiSnJqfQVrP3UIcTRmHbPo6qP9svLo9foyU8rqRFdjmxXKGJTjdSMqMbei/2JecXNTA
 lSo8540C8BbziY3OVsbFrOpATowMx9Cpf2L43TD6dKWvEKjnc9KtngJ4oL8+//vvK6We
 Acsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787150622; x=1787755422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RaCfQFebjYCn2S66Pq0NvkgKTMBfSiwnMigGYE1IGd0=;
 b=dEaVu8Bpd8iaXAEbO46+tR8lhd2uOYkOOxDJYt5N5hwsdZW0kO0iFzCIKWLF3j2xnP
 dM0RZbd/+ICfZsK2xrZu6jyStpR6dJUEp6K/nnumpaCqZQjz/fM6HuxNvU4ILfV997si
 biCLthAToCBjuFr1ZAul0T7heygCMOuAM+V8/SXdixCST5tcLxvv5ayOag3jhqwRQBj9
 uyJ2mhDlnLpuVRduau7V6xerUpblBiWIjoPIPlW1VmC6zyaTq5/gI4s+6EJmoAKEjgA8
 bAUXpti6I48GyGgyeNQFJq0gOY46ITdd8HoGXNZat/zU4kbPdY84DL7B8PFbhjFTgRHH
 nlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150623; x=1787755423;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RaCfQFebjYCn2S66Pq0NvkgKTMBfSiwnMigGYE1IGd0=;
 b=ibvxCT/l3sfu9z19iJtZf1kbBelogm27CAnh10eWwwLzR1CaEtI6NM2Lr3JpRgyJ9n
 G2nIFXeFmrMZ2FQvlYsO+R+s3UHH7NGwiwMgtmz4j/TREvCenkH9XJqOBzSj0kQR7imk
 xegL/pte/tQGfDBTGDC3qXoZTBwhiQCs5J4veWE9ulwJm1i4nmD2e6OA7iTgnD1kXL83
 iOxXtD1bK1xafCjqVP2NVAN1Ba0JQhDtNxkb7WTOFLON3FyKQ3I6oDdjez0FZzf9Yx3J
 eL75/mRk69YcH9z8Zpaluq9OlOXcljymkXNHGLIsGw2+5S0g+5IkWAyb59VNnY/PrOk2
 nGsg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpyo3TWzD3TDkBhiUC8+071eEUzR7g5t8v+PNffu6ZAaBSnDQCe2EojR7B586oKTvGOAil3NFsUnHu1@nongnu.org
X-Gm-Message-State: AFuF++kyRt9cFTGQ1YCiWHOrclUoqQ+MlwGLC9lylqW9BOG0/0NTPjpP
 pXxRYi6AwWJqI25OH3p/s2H33AgPtYTb6Wutr8VRfImWROemuaYXeDwDDCUhDFeoZ+ATn/s9qwh
 BctH6UkTI+3Op5A5Dfuc4w53Fsycvkug=
X-Gm-Gg: AR+sD11l7Ju8hrgIPWYKG/n+W2/Goibz8N420awejHue813Fd77TaqxxlnWg1s5Cgk3
 DrI4rDimHqvv6gWPWe0CVFOrFxLrARNY++F2bQLOLkv2k1lDYlFsko8olOb1EmkiKGv6mN90KaI
 9XSNrfjwXXfKd1Do5rLdwAAC269qNbAEIK1bMFoBu5WAPUFLgHXKXBq/BJ9Z/cHftthA5u19RQH
 HMiH4fFwueN8nA5SG57zxjWcl62FWYQQ1PHrRGrNNZm3xl3HniliCOcfo4ysQJfaE2O55N5+kvf
 RhHwe6aw9d1T3IkL+fDOJNsMjobn2Ucyjuiq71xXSazm4WnN0Pu1u9sK9W3dBuDy/HFWbZUoeaR
 Y
X-Received: by 2002:a17:90b:5550:b0:38e:4f31:8412 with SMTP id
 98e67ed59e1d1-3957f993466mr6951500a91.11.1787150622432; Wed, 19 Aug 2026
 07:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260818134543.654949-1-colazcyg@gmail.com>
 <20260818134543.654949-2-colazcyg@gmail.com>
 <CAJ+F1C+-EhCgeM2cK9QfZrN9c9OezuRO4E7NGmHiTFN=cHQLKA@mail.gmail.com>
 <e32a2d8b-e701-492e-b09b-f83eeb44da1e@sourceandstack.com>
In-Reply-To: <e32a2d8b-e701-492e-b09b-f83eeb44da1e@sourceandstack.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 19 Aug 2026 18:43:29 +0400
X-Gm-Features: AcwNN1Xu1sAoizVAht1Y-xeOdTnfc1izcarvdeDUty7c7kP4bOaa7s1F5zOlBig
Message-ID: <CAJ+F1CL8kFYjgU-yU67kX2oX9PEapzz301RmW0=dPtnkffN-0Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
To: Christian Hergert <christian@sourceandstack.com>
Cc: Chengyang Zhu <colazcyg@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Wed, Aug 19, 2026 at 6:40=E2=80=AFPM Christian Hergert
<christian@sourceandstack.com> wrote:
>
> I have concerns with any sort of stateful tracking and/or application of
> properties as they are prone to data races.

Good point..

> If we want something more extensible for the future, we can use `a{sv}`
> with well-known keys.

That was his v1. But then we would need to have a way to introspect
the known keys, and this is not really binding/tools friendly.

Maybe we can have a lock on the interface? that would be per
connection, but it could be enough?

