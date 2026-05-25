Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45635CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 16:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRY1Y-00058y-Pl; Mon, 25 May 2026 12:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petr.pavlu@suse.com>)
 id 1wRY1X-00058a-CN
 for qemu-devel@nongnu.org; Mon, 25 May 2026 12:19:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petr.pavlu@suse.com>)
 id 1wRY1V-0006RZ-Ay
 for qemu-devel@nongnu.org; Mon, 25 May 2026 12:19:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so63301495e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779725963; x=1780330763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6YA+/JJXQ9abERc/NViF0XyaL5qdJ2pUb4chRkVwshY=;
 b=S6bQ8L87gA+AJy/TMy+Dw9msKlcmrfoEmSarVUnp3te3YW6DXXORjhgBUfX7MMv0Xg
 YlWec+8lz1dg10LN8CULhj0EEXCPF+o5fHywyjHMZf+YQNMwEe9dHC1g9n2qyxrea+G3
 VSCcz9CTHNGt5KKy2c8Ty8Slu03RAxlvO6YXiCgoOtuY88rgmOjLyKvLCBDUd6QorHtw
 0NO2jcALB3uqGryQNp7HdZ8cDPHeIYORExrGMrYIgGVecQ8rFML2HKBO4j8yzGzVXEeX
 mktrh0hZDLVEFb3uB2tNv1A16VPaoXljBTjyajF1YJ5ZOiqvYH9iZcgi+9vJJUbl7lNL
 8zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779725963; x=1780330763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YA+/JJXQ9abERc/NViF0XyaL5qdJ2pUb4chRkVwshY=;
 b=QK54rrx4/NKckOimDFuRuJaWGC/D4O19tfve2vZlN8f2MXWdpTxfW9NlKxHy90JGAk
 Mvfe8zGWLGQ+D13MCfCOYBtXTv7rDGUhentMRM9vN8Rt2XFXb7o0ZdqWl0KzUM57p8LI
 CvDkJk5lFGmyjENscGXy+rEVqe5ATOf7vjs+awAsywASglNILWY4DMxjZlXEUQozC3/Y
 hbZeN03FJiBzFOf2c5myt1xp/Cehzib3exHPO61KEjNmnyTQCWu2FS/et+q6lEuL0lDl
 rqVlVtwQn7GPytBb2TSCmr6HrH+r7xlHP06FhM93+HLuEgzDPvDyDryVDk543T8gThDl
 REUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98+MsHtfIUmrlxaMMtEriIWnvGgi4GSO4zl0skN0KQczuOBHms2AY4wTKblR9Hcsss/e+xmf89aQsg@nongnu.org
X-Gm-Message-State: AOJu0YwmTmjHEh2uW7TJXM6vo/rdr4i/v5A/qcJo7BR+71sUcXrpXF4x
 vOuTEutfpb2mxjZ5bES5TeTBCNQdvzFtyiUa5t8FV/fwdq7wbONNK3x9v0SlHd43Hkg=
X-Gm-Gg: Acq92OEK+8MoG+XZp5PtiyDOBIthztoOC1/2cg1BtFcjfIqypDjzoc16MppRTWJ3BqC
 ltInStotM+cQUEbcKzR4NQD9IhVdkUNHHZoVTPBq2T+CwwDJrEMGMFvWTI+WGKpTk9TLIlkm6V7
 JPxuFqEMkpW77w24DVidodPIge+6iuz9cb/5/L6pywk6yZoygaXY2xD1NLbGrW+EAFK1rL1N0YU
 1fuqlL/wH4MnKoEhYpzCz0o1yjCPOjdtCm8pSUKLDnRtBxdL386g9cW02o2UkEvarI0OLB+5+Ne
 q3E1Lv+gurV4h+lWG8gNu6uc4iZpTU4HdjX0AXlkktexyoQNFfyDIn+d3WSOLq9wc+m9X7IurZ4
 CPeqcifD+KSkpqEcPoJDQpCZ85fDW6QsauAPVJ8dqKkzclQDvuHci+7OW2ru42iotAvushvH0JN
 iFlbEmDdUIkgdlk2Pmkd8I3LZaeyTOOYRze0V8TPDDokdVeqtYgK/G/1Xxx3L+XTx4uP50S3sDB
 W9bb/YO6DgrO7XWMeFkMriXbVE0L0uyVRK49xYniYI4RUvnMEFxGsftplQzxoSkN6e1yA==
X-Received: by 2002:a05:600c:3b07:b0:490:f7c:b19 with SMTP id
 5b1f17b1804b1-490420f67f5mr197977845e9.0.1779725963153; 
 Mon, 25 May 2026 09:19:23 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49059cc9a91sm48939425e9.1.2026.05.25.09.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 09:19:22 -0700 (PDT)
Message-ID: <a4c7ccee-6189-4c74-bad8-57d1438c7d8d@suse.com>
Date: Mon, 25 May 2026 18:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] moduleparam: Add seq_buf-based .get callback
 alongside .get_str
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
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
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-6-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-6-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=petr.pavlu@suse.com; helo=mail-wm1-x32f.google.com
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

On 5/21/26 3:33 PM, Kees Cook wrote:
> Add a new struct kernel_param_ops::get callback whose signature
> takes a struct seq_buf instead of a raw char buffer:
> 
>   int (*get)(struct seq_buf *sb, const struct kernel_param *kp);
> 
> The previously-legacy .get field is now .get_str (char *buffer);
> .get is the new seq_buf-aware form.  param_attr_show() prefers .get
> when set, otherwise falls back to .get_str.  WARN_ON_ONCE() if both
> are set.  Return contract for .get:
> 
>   < 0 : errno propagated to userspace; seq_buf contents discarded
>   = 0 : success; length derived from seq_buf_used()
>   > 0 : forbidden; the dispatcher WARN_ON_ONCE()s and treats as 0
> 
> The default policy on seq_buf_has_overflowed() is silent truncation,
> matching scnprintf()/sysfs_emit() behaviour.  Callbacks that want a
> specific overflow errno can check seq_buf_has_overflowed() and
> return their preferred error.
> 
> No callbacks use .get yet; the legacy path is still the only one in use
> after this commit. A subsequent commit teaches DEFINE_KERNEL_PARAM_OPS
> to route initializers by type.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

