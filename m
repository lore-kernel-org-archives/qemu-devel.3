Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6A2CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 20:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRbUR-000524-LJ; Mon, 25 May 2026 16:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRbUQ-00051h-1U
 for qemu-devel@nongnu.org; Mon, 25 May 2026 16:01:30 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRbUO-0006Q6-5j
 for qemu-devel@nongnu.org; Mon, 25 May 2026 16:01:29 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65e39d1dd38so9136185d50.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 13:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779739287; cv=none;
 d=google.com; s=arc-20240605;
 b=koDgYnoRKJHLrpcFHIeu07XK4gicHaitAe/Cj8/pHA7PsX6MSxjw5NTplPg1DSvMuM
 y7opDMDgusGoufjuPmvC/D18+7JQyFyBzzfLe0kns+wc40x7OD6mUnyl8DU3/MrMIh1J
 44tkYKO58C1OXyjbKOSoJxZjob5m97XsMh+oow1zG2vU+Mtll+fdDqyjd3102vOv8IQu
 vzRHei7VGWIGT3YMZDGPJOA4Yp2gQatNMRrRkXUFBwDudJLZ5+3i0IZBoL7GqNsltlD/
 MybDvlrdyeFUnrikKUrOgEgD/2d+jLW9w8rz5zDF6nH+9wibP2j9zfObvQmYz5DKlJCW
 y8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WhSWEnC2ecVc9BwA6TVyk86odnQWuDcS2E3f4VRvhRM=;
 fh=bnI6YOyuNfxrG7pMwm+vCyspagRL9htO+PWCH8Y+nfA=;
 b=gSprEzSKuW13Zu2X7bEH8Z8a4Ntu20ebbZZCbgTYigzeqZrazSWDn5GAi1zZoWencu
 0nU8kglvzfuo6OPPLZpvKSIH00o9ECLbk5ChVOa50RS8HVTohABNDKYFahiA6auET0ZB
 lkLaQwXEhEEDe6VlPNm8eGQKsL9AFqqUPAAJ4RGvdgjio/ULU9btCe3iDjNhkxr2H1sj
 2I5AT0IsmC66GpegnozpLUE+X69vxI2ORiMBcZdD2R53eAn7BfmLHkQ5OjJhnG1D8Uzy
 vFAzxcdGi/Z8av9ZaDz1HYFDuO4jGj7xw9RmOnqOOBTPkKzKr1DjEnNjS6z3g8HjAetm
 w74w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779739287; x=1780344087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WhSWEnC2ecVc9BwA6TVyk86odnQWuDcS2E3f4VRvhRM=;
 b=x65Kro9UieIPOsMXt3myxm2uEvT54vgbYXQix7mK5MM4G9fku4wOJLrlHGfobJ4ZLO
 9PWidGgDNpiyRbDhD/Xvinoy60kXwOc++27wFGJ3C/pfZwFMo6q/EWhFMrQ9pYRx4VpC
 3ia0GQ993XjDmg8NhaMRuVUcNSoL89600xYM0EUHniGPOOLnRsSKjT0Cppg5qZlZTosA
 sACxjI+4d/zHfDyOb5FH0jrADHH2pMT38ZiyW7hQNc7YkolpTCh4sLOb0jSBnrtIWSpa
 RAnsqi2npCT2Kb41UahaA+7xQP4+6Yt6ynPpYWSDKDukYaLg7I4Ldv7Kl3vK8042DZAY
 Zv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779739287; x=1780344087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhSWEnC2ecVc9BwA6TVyk86odnQWuDcS2E3f4VRvhRM=;
 b=VfYVXATBCSU8Qju34MVawLa9bZLr2KlHGcamox3CevDd6u6kan1LbD4XmmJr3m2zfe
 Ue9kpfBeInoCUGHKLOjmuTrZclQZYN5naQT3Gtbmo62WhC6hdhmOGaYgSbHSWgfrIs3P
 SNhrLRVDCqkiczmClAYfAepZcJbPo783gtxPsAe5m1DhCcKOT8BjGzk8sG08SOPGEXBh
 RSr5IHWRSdEIYinoB4Y4P0gFIyREGXKnwyBH+V1QDow6Ag8Vgc2L0c6y1B21qaryPFbI
 zL2GtFSAncCTud/++yTjvXw5r2unb7JPdfOx++038RApmdCAFEHl7kZTqWkfesh5EMeu
 xByg==
X-Gm-Message-State: AOJu0YwPIWEBsu2OdxYGj4h8a6bOr/FW8NWG1WlDnl8opIw6/PVodPrL
 p3enNNMnwIg4NI8DEFf0MTCRxfKVAg452KiR3J/FL7sNp7JeiI2IoMI/TMGcSDbfR/3761Fhugh
 5ny2b8K6qnM0Fb9FsCbtxqQtqVbZOIvinJn2jB6Mh7A==
X-Gm-Gg: Acq92OGWiRLL5XznRAFrSnOrdiTbtv4js7yNP8Co0fu4lz/kzgmRywn9Ee/Buw+aBj+
 hc6UJ1CBQKEi1tTpYsFz0L3aTAFJ0TVZMdKUbE+bXBOJ+XcTqIxju/9VEkjxVWrRBbPjhn8BK3h
 yhWev013zDkQmxIkPvaEPCb0HaSW/devfjDuDPBhrkbPOG6mOo7rduK1HawSNPUJlQzz2kYb5iV
 VqC1DIgTu/vUgC0PsN25DaoYCtU7m6GwtGBYxemMHPrhz2A200WrxMHuwVCLH/FlYsyMQuk3dOR
 jgFm+NaOEBDMHm6XN5bILEmBEgbY4xpDDrSzLu4Pqni7+eFNqNg6oAcMwQf8OPjrbCI=
X-Received: by 2002:a05:690e:140e:b0:65e:c62f:cd29 with SMTP id
 956f58d0204a3-65ec9914c4emr16402216d50.44.1779739286594; Mon, 25 May 2026
 13:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1779723483.git.balaton@eik.bme.hu>
 <d6fff532607b5153094cd6c72f78a2de5672aaec.1779723483.git.balaton@eik.bme.hu>
In-Reply-To: <d6fff532607b5153094cd6c72f78a2de5672aaec.1779723483.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 May 2026 21:01:14 +0100
X-Gm-Features: AVHnY4LlWHiTcNSV6H0hJklAZudGuGI5uug1LhNe7GqXbcn2hEPF9ITjp0PvHeI
Message-ID: <CAFEAcA9Nh9qZ1k_Pq04ajdP8ObrNpen4aYeu-mPNiYbRc9ho3Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] memory: Export memory_region_set_ops()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 25 May 2026 at 16:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Make memory_region_set_ops() function public. In some cases such as
> when devices have configurable endianness or different behaviour based
> on settings it is necessary to change the ops callback after the
> memory region is created. Export memory_region_set_ops() function for
> this.

If some other CPU is in the middle of using the old MemoryRegionOps
when the device swaps them out under its feet, what happens?

You could also remove the old MR from its container and add a different
one with the different behaviour when the guest changes the config,
or have both of them in the container and toggle which is visible
with memory_region_set_enabled(). That might potentially be more
awkward but it would avoid having to look into the memory region
API internals.

-- PMM

