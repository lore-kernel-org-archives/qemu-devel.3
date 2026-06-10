Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43554CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQ8E-0000mc-RM; Wed, 10 Jun 2026 17:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.cromie@gmail.com>)
 id 1wXQ8C-0000mM-2P
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:06:36 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.cromie@gmail.com>)
 id 1wXQ88-0002rx-Ms
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:06:35 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7f5eb760240so6968387b3.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125589; cv=none;
 d=google.com; s=arc-20240605;
 b=kJSJEInWjCrvRQe6rCN/1cBG2fSHHRUd6YEQfxiseG6XTIBx+ZnxNZOtKL2IFCJFyi
 /J1ArlaD+ROvZVFaAmn1FgV+MY8iCUOB9zuYWpUAA5tGZ2a9kuG0yJJAUZvD+nYrudHf
 feRrsmVIoz1nYMfNy0ZmzNgNbZcpwewAGWSTq+6PYlOvrlIUaOHanpZQnrHJ5zTldXU7
 WhccptA6nWZpE18RSo6rB6VEP951zwvarGlkkj11AJuRRrOF1DpaO2pF2HJKyaazeonw
 LmtGenc4848RRCLXQJJAF18HEoSYfVBP+q3QxGzmnJ+Jv7Tj2yPIExp3lDuQaNHGrMCZ
 iE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
 fh=PpOhKISkIJi/h96gWKi+mfaSfM6y8W6NaZqRAf+J8bk=;
 b=iMlPObSrTP4c4jWTRABQBAvXLLwZACKosYLtmrBXS+qzTK37I9UWD/RviCr2ZxTqjK
 norwzUDYB+FhDxDZuks0IM6RgZXCk+FM30F4E92mvxmj5HpV6qNnjYXl2PlCaltZiKt9
 S3a2amjKVPQAC9pT5JXkZXBnDu0H1sgwSgQ8AL+fCCK7xXNxsfSX8+CwukUvMRrMaFyk
 9pyVxy/JZsxUwKtEUABX7SYM9iVikwc9kREarySRp8Yv+zvdw8FD/vQfSkghenjmyKsH
 D5lUgzdr1zx5o+W37kPxQLvaA7HRXeYB+30kb/gRhQmBp5WpF9Q5v8UO0l0U8tVJPijm
 Is9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781125589; x=1781730389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
 b=bXcT3h2teYdIFzXgGGkPMBF6Hfz7C4JPfPpbAU345KgEKQrDq9785uWeF/EiryAAFc
 RHIhVGUBQRS0aJgTf4xtctm2Pde6vsHMnjVVbz3W/TWx0hgTpZaFQ4Ce7EIC20Co7RpD
 7Qpq3Y3NhT+mGTadj5wgtoIvzkLf8bGJMJAxbIBDOKNOMji+6OTNtWe57p+i8Nzga/SA
 Wjt8bS5UoIoq/Q2BXUtlTL38CDxGsbO0s6by3rH5TS/YWFdubJIN6SuohPKuM+KyHoE4
 dAGJ1qYuW3L6F3y/B4Vng2iEIiFsrqbbGiPJO+MSMGaD3aOG9sNL41xAl5GGbt+n0spT
 Bbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781125589; x=1781730389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
 b=S7lCaWefjj4hvO5aQLMkikOprrqMTgTa49dicDY7H7wyLiCIT1yAi1xfJNq4p00wo+
 RU2GHItZqq9ex1BMpZdg7KY5jD/r0zkkc9eY2mJ/ah3Pmqa+uzJEG5ngQmCWpkB31pGW
 h0pvmOtPWOnWWbc5rMNqNJDEX+3B1bhJgXEqruHnHDZB+Wx4Y7iyFae7V9gboBhV5I3O
 s8+xjsNCUT9ezwhpG4mWgC2aMyEFN8CXd7l59OQ/BLXELfCoI70voXbaX9y+jExbbVY8
 ioBs8YA7riHVK8jKzsbfVJV/qFABPh4ud7dl16H0bfz1ob3Cdl8FK1TK7VapcU/Lmclb
 05PA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9a4vgUteuOgGQOb0QaOg0jW9xL1QoT5lZpkW5i/Ttgcw5C4gW3zfSQYY8Vr7ipWWYqng3kegg0Un+X@nongnu.org
X-Gm-Message-State: AOJu0Yzx0V9jBF86fdvVR9CN4wz6H0Z5eW3MfxfWj8UxTkuNJE7KRee6
 OpCL8KKizQZZiGbRKJNKSFi917x4Cfv3vGCzFHOG2In65OV0znWuOOsqfMaD2seM9u5fNqX7kqw
 YAHtj8yEecWFc9MQKJ6jTh4T2nC2jSxo=
X-Gm-Gg: Acq92OGA113YxdZHZuBLz2XJO2t/Lx9IRAQUPW3vEcgu72VUMF6RNfd5i7BNNsyXCUh
 99n03Fmg2pg6h9rkLwXm3kqr6scjo8p2YYHFCWmJ+OZEpcDNDfNz1tjzc8uA9k2/TcFyKdMV/Ma
 x5lO1IAm2Zrd86szNZzfFdh6bk1rxIr7wUeDoiutncgz9Q3edGboxy7NP/r3UkfMPo6CnDkc96v
 KgqPetKvzWPHjV6AU6e2NRqPoQcZjMxZ+l9cJ6MPtmEtxq+llRYdJ/63Ovitj55cm4Yy7AjODzR
 0XJkmiFQ0xrlZXwD1Cw4NmqpgA==
X-Received: by 2002:a05:690c:45c5:b0:7e9:ab56:3c99 with SMTP id
 00721157ae682-7ed0adbb616mr276188567b3.6.1781125589039; Wed, 10 Jun 2026
 14:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-4-kees@kernel.org>
 <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
In-Reply-To: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
From: jim.cromie@gmail.com
Date: Wed, 10 Jun 2026 15:06:02 -0600
X-Gm-Features: AVVi8CcLXClq9Fijm8VjZF47hQWmos5q_iXrehNZDw9kSOby-E_cMxEQI0SK-hU
Message-ID: <CAJfuBxwRuT1K=rjPX+sdNyYurEJ=OjqbJaSa_S6JnY6yzTwTvQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, 
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Baron <jbaron@akamai.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
 Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=jim.cromie@gmail.com; helo=mail-yw1-x112c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 25, 2026 at 7:35=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 5/21/26 3:33 PM, Kees Cook wrote:
> > Using Coccinelle, rewrite every struct kernel_param_ops initializer tha=
t
> > sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> > for example:
> >
> > @@
> > declarer name DEFINE_KERNEL_PARAM_OPS;
> > identifier OPS;
> > expression SET, GET;
> > @@
> > - const struct kernel_param_ops OPS =3D {
> > -       .set =3D SET,
> > -       .get =3D GET,
> > - };
> > + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> >
> > Using the macro for initialization means future changes can manipulate
> > the struct layout and callback prototypes without having to change ever=
y
> > initializer.
>
> Nit: For consistency, I suggest also converting the few remaining
> kernel_param_ops instances that specify only .set and no .get, such as
> simdisk_param_ops_filename.
>
> --
> Thanks,
> Petr

for the dynamic-debug changes

Reviewed-by: Jim Cromie <jim.cromie@gmail.com>

