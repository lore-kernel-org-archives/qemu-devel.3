Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1986FC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76lq-00067H-Di; Thu, 17 Sep 2026 03:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x76lo-00066S-27
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x76lk-0004ps-KU
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789630974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PV3zlnIIVcoEWIMaMjQD68AZzhpgxJ/zQS6Tgz7Rak0=;
 b=NiwMvy9mTklQF+iBS4x6H+IuQjDQ8uMsSOMqDzTBF2HT9Khn7h7m9e33A+SJWe66P9ScMH
 eClmoyGMbdm6IgpGo3sYxZLvvNX8zBdjChWY9YdnCZ8uFCT2cmk+8WtFKWmn2a4wk8aUs6
 TqXEPpqug3aDY67a+iBtXRrtVOC8T38=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-nRXs_4PmNI6kZqHBZz2rFg-1; Thu, 17 Sep 2026 03:42:53 -0400
X-MC-Unique: nRXs_4PmNI6kZqHBZz2rFg-1
X-Mimecast-MFC-AGG-ID: nRXs_4PmNI6kZqHBZz2rFg_1789630972
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e6422198fso3376915e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789630972; x=1790235772; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PV3zlnIIVcoEWIMaMjQD68AZzhpgxJ/zQS6Tgz7Rak0=;
 b=mJPJKrFXYsNMOgljhmrMcALEwCboarg3bjZ2akSKOqJoKqhwcSVvdN4O8P5U2E+pmh
 KARMv+w0cLwZwVOHnlGh4V1IvBnh1N3v3b3O5dMXM5JfVs6bPKkKWS5mfqc1wT2szB8v
 u/od4Tq7nZojPwFRI5cJx8pisLhsmXBsqPOuJ8wBUosoe00onzNhg+6a6iMj/lkIWKh5
 i/W+6FKAof4KzmebD4Pkm5XH6Bel05hwYoXmQrWEn5zTH3WpIcmAdvyYWOc+IUF/RH1z
 h9aB1O/lMA+gA8NMZFbK1oosAIi81o7Vk8MCheeQSgIEOqAqwY2Yof6lghQAF7EbqwE/
 /vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789630972; x=1790235772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PV3zlnIIVcoEWIMaMjQD68AZzhpgxJ/zQS6Tgz7Rak0=;
 b=CI3+Tq3+lIKWKf65hUndA94DdmhxDOEbIVx41bbRHKXT1W3LVwyE5jC9l0g6huhnaM
 +K63iAlbj4nf8/27ogPUIwYcP7JdqZaeEX0NRFztsczE2KrIBVT7rWCh4pbQzdJ7QC+b
 eUMwA7zXUpNTO4vPcvtBTXwZNfmW17AXomK0QfZ+zx4SPPBnQkfcA5RBbkl0YLiVMIVW
 ha+jNS/jgL6X0RMn0hmLttduJZTtQdgZKVoWvFFOWi9iSJ4I1wC77HPLthax59n7bfCY
 +gI9yWDT/nYwaQhuEZvMCqHStKofGwtFIOGba/b78s7KyMQWZ20t7T6l40Ql/bSHNG52
 ekUA==
X-Gm-Message-State: AFuF++nVkA0WDobBAV8TtC+Ke5ObrsPE9GMTEfn7kzrTUpeKb87gffiH
 1nfhfEtNRxwRbBfavji/4DHk8G/0ynGQs3XE0QQdDqRg4V+LrMHh0SPnMfNSw3uMqlXVxYTCIux
 TTMyIsRh1rPu85V2EAdBOQQ76BrdydgRkjRoH80IgSGJhvwmUknjFQ9J2
X-Gm-Gg: AYBFou1U48qkD1W04GVqac1VxOJ8cSla39p4pZyvNhl3UAA6Jry49nSdd79xpVYzZOd
 Y6udi2wZPvaFeZ04e6gCV3J3IqEzF9RcM8rANcj2kkds8h38gH5KOjUO+5Mqv8LHlrWZHfCbmi1
 88jYU64hEDPdnbxgcFcS6bj09+UHyEXzgyxPiiGODOpgIeq1ttR3Zis0ZT0WUvIx3LlPcvb0Y/6
 w4fNuKfuR+QtSyp737GZNprzDt5gDqrcwT9qhcTY4jVv/W9RKwKwqMAShzh/l8Ug8rbWtucAStr
 /Beey/MvclrWXv3LBhYCfPuNsW1p14gbwFcgGrCF4LoHu4twzRfcAVsER6xZdWXdTBm3Bp7z9+q
 uc/uoZQCKyGAtGGgXZ9pdGp9/UBULbWyrgLZ0xE0NWLCCuA==
X-Received: by 2002:a05:600c:1da8:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49ec0549868mr133246855e9.16.1789630972176; 
 Thu, 17 Sep 2026 00:42:52 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49ec0549868mr133246165e9.16.1789630971605; 
 Thu, 17 Sep 2026 00:42:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847ecf52sm107646205e9.2.2026.09.17.00.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:42:50 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:42:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Tanish Desai <tanishdesai37@gmail.com>,
 Aadeshveer Singh <aadeshveer07@gmail.com>, i@uchout.moe, 
 niko.ramak@gmail.com
Subject: Re: [qemu-web PATCH] Add GSoC 2026 wrap-up post
Message-ID: <CAGxU2F6MSE3sskAhXOjFUu7QQwSBYWr-Qv5VCsYBpjYLQu8drA@mail.gmail.com>
References: <20260915153326.90014-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915153326.90014-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, 15 Sept 2026 at 17:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Google Summer of Code 2026 has completed and it's time to showcase the
> projects that QEMU's 4 contributors worked on this summer.
>
> Cc: Tanish Desai <tanishdesai37@gmail.com>
> Cc: Aadeshveer Singh <aadeshveer07@gmail.com>
> Cc: i@uchout.moe
> Cc: niko.ramak@gmail.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Aadeshveer, Nicola, Tanish, and uchouT: Feel free to suggest edits!
>
>  _posts/2026-09-15-gsoc-2026-wrap-up.md | 96 ++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 _posts/2026-09-15-gsoc-2026-wrap-up.md
>
> diff --git a/_posts/2026-09-15-gsoc-2026-wrap-up.md b/_posts/2026-09-15-gsoc-2026-wrap-up.md
> new file mode 100644
> index 0000000..c652251
> --- /dev/null
> +++ b/_posts/2026-09-15-gsoc-2026-wrap-up.md
> @@ -0,0 +1,96 @@
> +---
> +layout: post
> +title:  "QEMU Google Summer of Code 2026 project report"
> +date:   2026-09-15 07:00:00 +0000
> +categories: [internships, gsoc]
> +---
> +QEMU participated in [Google Summer of
> +Code](https://summerofcode.withgoogle.com/) 2026 with 4 contributors working on
> +open source internships from May through August. The contributors gained
> +experience in open source software development working on 12-week projects.
> +
> +This post covers the GSoC projects that QEMU had this summer.
> +
> +## Fast Snapshot Load in QEMU (Aadeshveer Singh)
> +When virtual machine snapshots are loaded by QEMU, the entire contents of RAM
> +and all device state is loaded before the virtual machine can start executing.
> +A lazy approach is actually possible where the contents of RAM are loaded
> +on-demand when accessed by the virtual machine. This can significantly speed up
> +snapshot load times since virtual machines may have a large amount of RAM and
> +loading it upfront takes time.
> +
> +Aadeshveer implemented fast snapshot load by taking advantage of QEMU's
> +postcopy migration infrastructure, which monitors RAM accesses using Linux
> +userfaultfd(2) so that memory pages can be populated on-demand. A thread is
> +introduced to load RAM in the background while the virtual machine is already
> +running so that on-demand loading is minimized (it affects virtual machine
> +performance). Testing showed that fast snapshot load indeed provides a major
> +speed up.
> +
> +Aadeshveer has written up a [project
> +report](https://gist.github.com/Aadeshveer/6a16579aed93f5d483bbb9419ecd2211) as
> +well as a [detailed
> +journal](https://aadeshveer.bearblog.dev/a-summer-with-qemu/) if you would like
> +to learn more. This project was mentored by Peter Xu.
> +
> +## Support x86 Process Context Identifiers (PCID) in COCONUT-SVSM (Tanish Desai)
> +Process Context Identifiers are an x86 CPU feature that improves context
> +switching performance. Without PCID, software has to flush the Translation
> +Lookaside Buffer (TLB) when context switching so that memory translations that
> +are no longer relevant in the new context are no longer used. PCID allows
> +translations from multiple address spaces (contexts) to exist in the TLB and
> +this can help if they are needed again in the near future.
> +
> +Tanish implemented PCID support in COCONUT-SVSM, software used by confidential
> +virtual machines. This involved:
> +1. Creating a [Rust crate for x86 CPUID feature descriptors](https://github.com/coconut-svsm/cpufeature) so that PCID functionality can be detected.
> +1. Adding a PCID to each address space, including writing a bitmap allocator for the available 4,096 PCIDs.
> +
> +Tanish described this in more detail
> +[here](https://tanish111.github.io/tanishd/blog.html). This project was
> +mentored by Luigi Leonardi and Jörg Rödel.
> +
> +## Observability Support for COCONUT-SVSM (Nicola Ramacciotti)
> +Troubleshooting confidential virtual machines can be challenging because the
> +host is untrusted and does not have visibility into logs, traces, etc from
> +inside the virtual machine. Instead, an operating system running inside the
> +confidential virtual machine could extract logs and the new Observability and
> +Configuration Protocol (OCP) has been defined for this purpose.
> +
> +Nicola implemented OCP in COCONUT-SVSM, creating the interface that software
> +inside the guest can use to read logs. A Linux device driver was also
> +implemented together with a userspace utility called svsm-tools that exposes
> +OCP functionality to list, read, and write data.
> +
> +Nicola published a project report that goes into detail
> +[here](https://github.com/n-ramacciotti/GSoC-2026-ocp-svsm). This project was
> +mentored by Stefano Garzarella, Gerd Hoffmann, and Joerg Roedel.

nit: since we had "Jörg Rödel" in the previous section, I'd use the
same in both sections.

Anyway, it's really a minor, LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> +
> +## USB Device Redirection for qemu-rdp (uchouT)
> +qemu-rdp provides Remote Desktop Protocol functionality via QEMU's
> +org.qemu.Display1 D-Bus interface so that the display, keyboard, mouse, and
> +other devices can be forwarded from a client to a virtual machine. USB
> +redirection is a missing feature that would allow USB devices to be plugged in
> +on the client and attached remotely to the virtual machine.
> +
> +uchouT implemented support for QEMU's `-device usb-redir` in qemu-rdp and
> +integrated with the RDP protocol's URBDRC feature for tunneling USB traffic. In
> +the course of doing this, uchouT also contributed to the IronRDP Rust
> +implementation of RDP (qemu-rdp is built on top of it) and FreeRDP (an RDP
> +client).
> +
> +uchouT covered this project in detail
> +[here](https://uchout.moe/posts/gsoc-2026-final/). This project was mentored by
> +Marc-André Lureau.
> +
> +## Conclusion
> +Google Summer of Code brings together talented contributors who would like to
> +participate in open source with mentors from established open source projects.
> +Thanks to Google's funding, our contributors were able to dedicate their time
> +this summer to implementing these features for QEMU and its ecosystem. We hope
> +to continue to see Aadeshveer, Tanish, Nicola, and uchouT in the open source
> +community.
> +
> +If you are interested in applying to future rounds of Google Summer of Code,
> +keep an eye on the [GSoC website](https://summerofcode.withgoogle.com/) for
> +announcements and timelines.
> --
> 2.55.0
>
>


