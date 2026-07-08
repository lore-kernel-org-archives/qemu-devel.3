Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5A2C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTN6-0003OS-0h; Wed, 08 Jul 2026 10:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1whTN3-0003OB-NG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:35:30 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1whTN2-0007Tk-Eg
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:35:29 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-39b349ae174so6451991fa.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783521326; cv=none;
 d=google.com; s=arc-20260327;
 b=MK1W7iXdND2Ou/oRolC63gu1+lzsq2pd+ea3vR8ydS3wC6lhAi1293dax0wCjMXqx7
 ku256ipzC1ykPl7bJYW5+1yMCQGTC1r8TMTgJlNgvqy3qKpuC+ok+iN6fnRq/dtxo7rM
 5aW7RvjGdBIwAb9NWmBFtlo69fuJMpUUv+GyY2W3wGh/mEstN86eF71ArtpjwW7oKrXg
 RJX0u3k2q1ZUFcpC9CGzzVcurNrj0zgtrflf76SN1J/T3tWjJpHMvClhT31SWh61ACdZ
 OUewS2fLhKURrRmCoa/gMQtNhLnIsZNaIbIxSKYAIxx8aAIt0ajiwHqMROw345oJUlB3
 qoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xAY9c/8KHTfT/vTbe93BCmKfVljr86M8LY8VDf0d6T4=;
 fh=NT0kq7NgLJ0wOp/qMyvn1NIPXsDSAQYGUZFkUZ2OApE=;
 b=HwuUH57ZMnfZW/gvyeH3tJfDvrJkYJNpm94TCb4e4hNugMqxsI784akwCPg/mLliQ1
 NmwxRCF14goHl7qK7tFdaRrKRi4zyEDrwizsP5JfjJkaF0AmFMkpArZN8nUAfJI8X4MM
 a4Gqiw3GI53jPblSN0X1nGNn/D0aGIdPvj6/8Sya4MtEMrg8rvWU9irI+iUVXYaoBZFs
 1nHgzrHtucFSSZeLbO/kg7krRHGV4GuUutE14bqvUROfZM2y3kTesvDMtKhvDyhmvxWr
 Gym6rM1c38L5wRCOSw9p1EAdqR5QNmA92XOcT2F2t+i4s5fD696TlLm+yyascRzLPdGG
 xLqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783521326; x=1784126126; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xAY9c/8KHTfT/vTbe93BCmKfVljr86M8LY8VDf0d6T4=;
 b=l/iZUDaxjvT5GN69nY6F8CamLSv6J1WG4H9dCc59Ez7m+9s524yfQvVtkAlGc46X6g
 HE/JHNJtBtQzklqYhH5HKOxGEXBP7X2KvSDJ19Qvsn0Nz60X84TGFT8uy50OGS++s+mI
 hiCzvv5YF1Zi6bGklvGO+y1K5Tiz9hZESfzhMFlxs2wdtJGdSPsmdEaRdFI3q8dFnVUE
 MzdeQ38U+t8dfh9cXk9Z404epC+ZBwAirOSZD64+SY9mn/3poGofM2uGeBkM6WB02mQN
 En7w5YS5Aq8LO19wwvzGpcSR24b2C6PmmcNvApndMex+yKCY98NqESwb6tZTTdybffz+
 2dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783521326; x=1784126126;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xAY9c/8KHTfT/vTbe93BCmKfVljr86M8LY8VDf0d6T4=;
 b=J9lXNJB1P0UXrz4GliecsuydVEiHjTNKaURPhoh2/uhI8yUm4V9uT0Otpeldd79Xd0
 cJWxD/MWkvJwO/9rIhCvPFxGks5mtICbl+mCHvDzYLdb0XIPtyLAXjWunQyBon67oUaE
 LnXflGJlWR3KehHZXxCwu2WiLtk8I1ZAU+EjUi3hVPWVbue2cGP0+waiNNPS4h12PFtq
 0cx3uCML+lrEsKCJHIDepUhEncpFhzubw7fuL7q7kYHZwWird3tC0P7CWXfG2igsy66D
 OjgHFXFcfzN4Cx0EZTMy9t3grKH1XkqxMNbbzuPDemp/OmWUpyGBrDMArIt7p68rQddE
 r6Sw==
X-Gm-Message-State: AOJu0YzUK6e9S5njKrx2Ka2GgXZ3Hlew8dCVlkRS0ZsN/3qw/3EMkJsm
 s+HotOFDeMsk7CT9YZBTyBBcw/t4pdSjTZNt3EWvgLU5mB1iU8Hau8c0kEbU8xFtn96526bPd8l
 n4scVXd6jxe91mWyPyVr3qMbqNfE/TwE4q/rj
X-Gm-Gg: AfdE7cnJ9YClTR3sHzYWJTVbgSt+OV0j2TNvEEpQHUXN4rS0ARz2B+h8axRny7HVzd2
 Vsjs+nFnqAhWxBlt326c+DcXO2EG6ZSbkMH7B1TQ13CAy6seJFFTa0Bxzmm5z1/K0xfo+TTPQc8
 EfcuRiOfIsnw2qCOqEy1BubSi858W0FxROrmQoErRUCBnIXFb9ZBHqb6WItK/16opKCU0aruOSo
 UJhKpjXnmxzg5uDr1Qxn/aAjfJEs7uzahbVriwvhQY3SiVFSGT82S2ATVWD3Xhxb3HMV3mjHTSh
 LeKcOv1ShrSzbpWmYJkycyklwepfVEsf8tVi3YYoONtWMuOHqerwc6o92bV8
X-Received: by 2002:a2e:9b08:0:b0:39b:37b9:50f4 with SMTP id
 38308e7fff4ca-39c798db781mr4299041fa.8.1783521326160; Wed, 08 Jul 2026
 07:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <akv_HvRFc_J7Pm-5@x1.local>
In-Reply-To: <akv_HvRFc_J7Pm-5@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 8 Jul 2026 20:05:14 +0530
X-Gm-Features: AVVi8CfSOhrxp0mkcKzjrBRT1Y9Mnko2C45P21yLrf39nPb0F5E5_cprpG5GaNw
Message-ID: <CA++cPv+-+FR9tY=mCSS0tvcoPU=WfSwccF5j6GrThrA5YhbXvw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] migration: fast snapshot load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Peter,

That makes sense. I will add a patch to check capabilities and fail
gracefully before the testing changes in next verision.
I agree with most of the suggested changes and will integrate them in
next version. I replied to the comments on patches 3 and 6 with
clarifications.

Thanks,
Aadeshveer Singh

On Tue, Jul 7, 2026 at 12:46=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jun 30, 2026 at 01:49:33PM +0530, Aadeshveer Singh wrote:
> > Future direction:
> > - Add support for hugepages
> > - Add support for multifd
> > - Add support for vhost-user
>
> When send the formal patchset, you can add one more patch before the
> testing changes, but after the rest, to explicitly fail the migration whe=
n
> any of above was detected (e.g. update migrate_caps_check).
>
> It's just to make sure when your feature enabled (but with some unsupport=
ed
> setup) it won't crash QEMU but instead gracefully fail migrate QMP comman=
d
> (or migrate-set-parameters / migrate-set-capabilities).
>
> Thanks,
>
> --
> Peter Xu
>

