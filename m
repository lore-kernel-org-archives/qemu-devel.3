Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AA7C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76pO-0007km-GJ; Thu, 17 Sep 2026 03:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x76pK-0007ib-2G
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x76pH-0005Xs-U3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMUhvvG0Ebvt3jfStdmTmaoaxC3dsnQzfS83ggoStoE=;
 b=VpxA+Gr3BBly2RRZYxiB6CrjO2SlIpn7lTDtYlEgQMQWPd0kmQIt45/LGO35d51M0V3Z2K
 4o5c4S3F10hWX2v2GCFBuy/m6YdzLrepCS11I/9sFB+xF5TpjHTSUCDVk/4ZsiKXRnVHZ9
 gdomkGbQ64J63fj2tjk4iDMC00a0YCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-IZV1myu4M0mGkeUHH1wwMg-1; Thu, 17 Sep 2026 03:46:31 -0400
X-MC-Unique: IZV1myu4M0mGkeUHH1wwMg-1
X-Mimecast-MFC-AGG-ID: IZV1myu4M0mGkeUHH1wwMg_1789631190
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49d156c917cso2669715e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789631190; x=1790235990; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qMUhvvG0Ebvt3jfStdmTmaoaxC3dsnQzfS83ggoStoE=;
 b=KfWB+FqSZC/DBaWLNCEwEbFaEMT+uygyefyWuIZ8WBivAUWjulXP/p50HBm9hSh1uy
 b7Nx7loPQZrJrysHAUKL9mcnWZE6ZMOSs2tVblqL9I3aYLV7KHN11OgnXvo8Ip+d+2dR
 tOll/nNgVtKMttdJor6H5XlVxHC/moGzrEe1MUNLth5F8R06dVaU5HY13B4Ffz9cUZn7
 yWa8qU2A0jDQ6LIEt0ENm1+J3UAbElGVQfJI0xmCAo+C9PvQWuWlldh1mF8/IQF1B+wX
 C0B3J19hjaEKxxQa5KPBCADa8IZ8DLDDc81yYZUz/1M2yI4iCyuQIDy2jSVr1Q1553bN
 Z5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631190; x=1790235990;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qMUhvvG0Ebvt3jfStdmTmaoaxC3dsnQzfS83ggoStoE=;
 b=wK1ngJVDS4v2Gc+1e4PRBW21Il/07xjxhsMIvpAgmofXvGWa8DBzq/8TJT04yakVYi
 Kt2ud8sn22yvohi3F0CdKfP6fDKm4e2EJMQ7f2yPwBz4RfgiGlJGktV6EBJpy0klUe/2
 Sh2X/hEdu9tZYR9thiLzeqGucMt6Zc11Py1PafesmeDqDEsCN6gyakmiZpjF/CAeBsl4
 COSvw9N0G/AMOFGwkpuLdyr8oKGdZsj9dcv6/v8Gm6SS3FKdnYW2aZgXkQ15k4/o5dV+
 M3BilmRetKIx9e1zq9d0atzGYiP+bsPnQ7UuoQnWT7jVbC3L8KrngaHG1gIB9q1tK79D
 Vkmw==
X-Gm-Message-State: AFuF++n76di2U+tOhX4P9GtjxTJlfVJ2HWNHtG4IN0Iipa6A3+ExPpwS
 IS3Pmwpe7MQqoF2WUXePaof4ZTZle4F5IGPX9+kZuGnOoeEqFSyPHNKZAGRfEXJTL+V+oDCyjRt
 kbm0F7lZvHVTuI6kjEYHBji6M/1FdjdSwIj3z/Fpdan5+aGR+05yKxQJX1DHuEYWgVlE=
X-Gm-Gg: AYBFou3l+1VOAXzMLsemAV2MgMipbl0xiidTxiPUqlNsY5s87Lncy314b2dPhRfYCI9
 r4Cq4PFjYIV7Dcb20u5b4hszFDFlje4OtShgf+l4UjUBfBqW0u3wZIGb197797hy4G8tu65bdg8
 6VdDY/9O0w4aJRLEtySjHdzeXSc66dCaYcKl4V7zTDlhTIu7JAhDOtOA8/9cExeGJaQOMVpZXZD
 MwIRMH+DdTGb+OnnX3/Hwnl0JAPahPyyyHL1NREYLjRf4/2udhAGjr5X0w/nc8fciLL9go9MZKy
 s+KVCkYXr15YUXJ42w0noTAUQHPX4Dtzttc9kMr8iw/p4itrX9apZvPUXIsJOgB9EwKYT5hS4EA
 ShkzhdgQke7VaWLFrYdjDA9yIkV6eAAFYMpo=
X-Received: by 2002:a05:600c:4f14:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49fbd51fc62mr29824395e9.10.1789631190097; 
 Thu, 17 Sep 2026 00:46:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49fbd51fc62mr29824025e9.10.1789631189755; 
 Thu, 17 Sep 2026 00:46:29 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd75b7d6sm20337235e9.2.2026.09.17.00.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:46:29 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:46:26 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Tanish Desai <tanishdesai37@gmail.com>, 
 Aadeshveer Singh <aadeshveer07@gmail.com>, i@uchout.moe, niko.ramak@gmail.com
Subject: Re: [qemu-web PATCH] Add GSoC 2026 wrap-up post
Message-ID: <aquaoVLlKfOaBWsw@leonardi-redhat>
References: <20260915153326.90014-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915153326.90014-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
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

Hi Stefan,

On Tue, Sep 15, 2026 at 11:33:25AM -0400, Stefan Hajnoczi wrote:
>Google Summer of Code 2026 has completed and it's time to showcase the
>projects that QEMU's 4 contributors worked on this summer.
>
>Cc: Tanish Desai <tanishdesai37@gmail.com>
>Cc: Aadeshveer Singh <aadeshveer07@gmail.com>
>Cc: i@uchout.moe
>Cc: niko.ramak@gmail.com
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
>Aadeshveer, Nicola, Tanish, and uchouT: Feel free to suggest edits!
>
> _posts/2026-09-15-gsoc-2026-wrap-up.md | 96 ++++++++++++++++++++++++++
> 1 file changed, 96 insertions(+)
> create mode 100644 _posts/2026-09-15-gsoc-2026-wrap-up.md
>
>diff --git a/_posts/2026-09-15-gsoc-2026-wrap-up.md b/_posts/2026-09-15-gsoc-2026-wrap-up.md
>new file mode 100644
>index 0000000..c652251
>--- /dev/null
>+++ b/_posts/2026-09-15-gsoc-2026-wrap-up.md
>@@ -0,0 +1,96 @@
>+---
>+layout: post
>+title:  "QEMU Google Summer of Code 2026 project report"
>+date:   2026-09-15 07:00:00 +0000
>+categories: [internships, gsoc]
>+---
>+QEMU participated in [Google Summer of
>+Code](https://summerofcode.withgoogle.com/) 2026 with 4 contributors working on
>+open source internships from May through August. The contributors gained
>+experience in open source software development working on 12-week projects.
>+
>+This post covers the GSoC projects that QEMU had this summer.
>+
>+## Fast Snapshot Load in QEMU (Aadeshveer Singh)
>+When virtual machine snapshots are loaded by QEMU, the entire contents of RAM
>+and all device state is loaded before the virtual machine can start executing.
>+A lazy approach is actually possible where the contents of RAM are loaded
>+on-demand when accessed by the virtual machine. This can significantly speed up
>+snapshot load times since virtual machines may have a large amount of RAM and
>+loading it upfront takes time.
>+
>+Aadeshveer implemented fast snapshot load by taking advantage of QEMU's
>+postcopy migration infrastructure, which monitors RAM accesses using Linux
>+userfaultfd(2) so that memory pages can be populated on-demand. A thread is
>+introduced to load RAM in the background while the virtual machine is already
>+running so that on-demand loading is minimized (it affects virtual machine
>+performance). Testing showed that fast snapshot load indeed provides a major
>+speed up.
>+
>+Aadeshveer has written up a [project
>+report](https://gist.github.com/Aadeshveer/6a16579aed93f5d483bbb9419ecd2211) as
>+well as a [detailed
>+journal](https://aadeshveer.bearblog.dev/a-summer-with-qemu/) if you would like
>+to learn more. This project was mentored by Peter Xu.
>+
>+## Support x86 Process Context Identifiers (PCID) in COCONUT-SVSM (Tanish Desai)
>+Process Context Identifiers are an x86 CPU feature that improves context
>+switching performance. Without PCID, software has to flush the Translation
>+Lookaside Buffer (TLB) when context switching so that memory translations that
>+are no longer relevant in the new context are no longer used. PCID allows
>+translations from multiple address spaces (contexts) to exist in the TLB and
>+this can help if they are needed again in the near future.
>+
>+Tanish implemented PCID support in COCONUT-SVSM, software used by confidential
>+virtual machines. This involved:
>+1. Creating a [Rust crate for x86 CPUID feature descriptors](https://github.com/coconut-svsm/cpufeature) so that PCID functionality can be detected.
>+1. Adding a PCID to each address space, including writing a bitmap allocator for the available 4,096 PCIDs.
>+
>+Tanish described this in more detail
>+[here](https://tanish111.github.io/tanishd/blog.html). This project was
>+mentored by Luigi Leonardi and Jörg Rödel.
>+
>+## Observability Support for COCONUT-SVSM (Nicola Ramacciotti)
>+Troubleshooting confidential virtual machines can be challenging because the
>+host is untrusted and does not have visibility into logs, traces, etc from
>+inside the virtual machine. Instead, an operating system running inside the
>+confidential virtual machine could extract logs and the new Observability and
>+Configuration Protocol (OCP) has been defined for this purpose.
>+
>+Nicola implemented OCP in COCONUT-SVSM, creating the interface that software
>+inside the guest can use to read logs. A Linux device driver was also
>+implemented together with a userspace utility called svsm-tools that exposes
>+OCP functionality to list, read, and write data.
>+
>+Nicola published a project report that goes into detail
>+[here](https://github.com/n-ramacciotti/GSoC-2026-ocp-svsm). This project was
>+mentored by Stefano Garzarella, Gerd Hoffmann, and Joerg Roedel.
>+
>+## USB Device Redirection for qemu-rdp (uchouT)
>+qemu-rdp provides Remote Desktop Protocol functionality via QEMU's
>+org.qemu.Display1 D-Bus interface so that the display, keyboard, mouse, and
>+other devices can be forwarded from a client to a virtual machine. USB
>+redirection is a missing feature that would allow USB devices to be plugged in
>+on the client and attached remotely to the virtual machine.
>+
>+uchouT implemented support for QEMU's `-device usb-redir` in qemu-rdp and
>+integrated with the RDP protocol's URBDRC feature for tunneling USB traffic. In
>+the course of doing this, uchouT also contributed to the IronRDP Rust
>+implementation of RDP (qemu-rdp is built on top of it) and FreeRDP (an RDP
>+client).
>+
>+uchouT covered this project in detail
>+[here](https://uchout.moe/posts/gsoc-2026-final/). This project was mentored by
>+Marc-André Lureau.
>+
>+## Conclusion
>+Google Summer of Code brings together talented contributors who would like to
>+participate in open source with mentors from established open source projects.
>+Thanks to Google's funding, our contributors were able to dedicate their time
>+this summer to implementing these features for QEMU and its ecosystem. We hope
>+to continue to see Aadeshveer, Tanish, Nicola, and uchouT in the open source
>+community.
>+
>+If you are interested in applying to future rounds of Google Summer of Code,
>+keep an eye on the [GSoC website](https://summerofcode.withgoogle.com/) for
>+announcements and timelines.
>-- 
>2.55.0
>
>

Thanks for the post, LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


