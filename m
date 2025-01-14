Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841D4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkwh-0000c2-VW; Tue, 14 Jan 2025 12:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXkwa-0000bS-VL
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:43:12 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXkwY-0003fD-NG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:43:12 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3a1cfeb711so8599465276.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736876589; x=1737481389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VOJanm3fMiklHpPrXFl7GKmdJ8wWZdGoYFEBWIQGZAs=;
 b=yzIFKtzwUPycQTFvI1+W6JAOXylCRPHHPGlHbQdwAe7vtLDuJgEVAOYx9KAGT4MdLr
 jAFRla2xxBDcUXthbdEs2yXtkRU2QFgzxzTcY01p1CaNj1j/H4QRqlipRYr/Q+qB9hgp
 vhvTWGcKmX+wbM9Eh7ZBICnD5ouXGblZsRhlLCtFaXuyVhXQdXLo/WL3LJF5A5uXnv3T
 i0iV6lxR22fxQMwNDkhqDtvfDRSY1zwmMrgOjB+CdaTK0AF3jnfyBxm6rGYADNVREg+S
 INeVtkYUtIFRH/C9IBB8DcdnLKWbKG1FQNZymcx9qISLUh78LTfh9VHVI59J5cjg4M5Z
 U1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736876589; x=1737481389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VOJanm3fMiklHpPrXFl7GKmdJ8wWZdGoYFEBWIQGZAs=;
 b=GXhOCpPu3dRWzUoSypYhuP9fAJEuCcp161zXdz2jPuU43+H1EkFT1A+6AqaGOJm5lw
 1RWTbC9OFRUuGAKejY3kchwXPeQ6vQKFYoSK2/RBnYBP1hZ1qTashcCXOKCHYwp0XJDX
 qHp04Z/zxdXbLGmYGspfP2QN5mv7q+/jCtegwujh3QFrNKeFQtxZRi0m37xa1Vd1PQYa
 QiTzdQ8IBaFPKU2R3hAaaRJu2S9mFr3BC+EvpXRMPIMvqpnmX6+rinIynV0885WLQjec
 WewzyJaYwVTe07sxyyW+qEMG1VkP220IUab1YJVLGyEdjbhaH0+Ls4CRXYt+FxJPHNNw
 GFEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS8GvRYpas4wqDITBsBSdb2LB0GrPoNHntIGRRhNDry/fXUa0yZgtahUCt0HOaZJYg8Zg2AhZbfNQn@nongnu.org
X-Gm-Message-State: AOJu0Yz9W96snUvH5EyFLp3OhUksuMeD4pF59Q4K9xSCL0LVsQoYnUGt
 w7Q6+7h3y+jUTnlFNdYR8gsa8Y9Uniw5SO/OclfAdR7msMGRzqCVdLH6nNU9pSS5ebVLtUcGjiz
 n94DUha+y+MEMczSr04N9652zNce+LrBMmNCwJA==
X-Gm-Gg: ASbGnctaxTF1vSKq+5Uj8Fgxo3+jMXOu4uHfaar31OolduY6dvWH3vlkwiZ/4OCeDcc
 KxXcQlqa9/rfFbrP0TLAA2AujOn/qnbPy88tu2m0=
X-Google-Smtp-Source: AGHT+IFHI2ugc4IBpKbBzkYYlRPsJtE/jm5Lvu1i+inkSR2vTbx9riqf7vKRALGs0dJ6XeGKPhET7hLzbkvynDeM4FM=
X-Received: by 2002:a05:6902:1445:b0:e57:442a:bf0e with SMTP id
 3f1490d57ef6-e57442ac7e6mr8129933276.37.1736876589158; Tue, 14 Jan 2025
 09:43:09 -0800 (PST)
MIME-Version: 1.0
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-1-93c432a73024@daynix.com>
 <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu> <Z4AjkXbZeu3T94Y1@x1n>
 <Z4AldAcucTyqZ0HJ@x1n> <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n> <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n> <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
In-Reply-To: <Z4aYpo0VEgaQedKp@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2025 17:42:57 +0000
X-Gm-Features: AbW1kvYW_9IvLlh1P3scFecuhe8SpmpvAkcf0DjSY8sRRNT6egj7SqSam2SHq8Q
Message-ID: <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Tue, 14 Jan 2025 at 17:02, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jan 14, 2025 at 05:43:09PM +0900, Akihiko Odaki wrote:
> > memory_region_finalize() is not a function to tell the owner is leaving, but
> > the memory region itself is being destroyed.
>
> It is when the lifecycle of the MR is the same as the owner.  That holds
> true I suppose if without this patch, and that's why I don't prefer this
> patch because it makes that part more complicated.
>
> > It should not happen when a container is still referencing it. That is
> > also why it has memory_region_ref(subregion) in
> > memory_region_update_container_subregions() and assert(!mr->container) in
> > memory_region_finalize().
>
> Again, the line I added was sololy for what you said "automation" elsewhere
> and only should work within MR-links within the same owner.  Otherwise
> anyone referencing the MR would hold the owner ref then this finalize()
> will never happen.
>
> Now, if I could go back to your original purpose of this work, quotting
> from your cover letter:
>
> > I saw various sanitizer errors when running check-qtest-ppc64. While
> > I could just turn off sanitizers, I decided to tackle them this time.
> >
> > Unfortunately, GLib versions older than 2.81.0 do not free test data in
> > some cases so some sanitizer errors remain. All sanitizer errors will be
> > gone with this patch series combined with the following change for GLib:
> > https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120
>
> Is check-qtest-ppc64 the only one that will trigger this issue?  Does it
> mean that most of the devices will do proper removal of device-owned
> subregions (hence, not prone to circular reference of owner refcount)
> except some devices in ppc64?

There's at least one test in the arm qtests that will hit this.
I suspect that you'll find that most architectures except x86
(where we don't have models of complex SoCs and the few
machines we do have tend to be old code that is less QOMified)
will hit similar issues. I think there's a general issue here,
this isn't just "some particular ppc device is wrongly coded".

-- PMM

