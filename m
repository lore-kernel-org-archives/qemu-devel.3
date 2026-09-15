Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF03C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vbj-0008RB-A2; Tue, 15 Sep 2026 12:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6Vba-0008JP-DU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:59 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6VbX-0003Ww-9q
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:58 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso750651a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789488112; cv=none;
 d=google.com; s=arc-20260327;
 b=jxGoMIRmLJBnIu44vOoyke9//4EgnBISpSsQHQ8g2Oo8Ya5zvDv1K6CYFMQoVyQFJj
 8+vz2mdPiGA61Q6yZhLaqc10SbPsPRzV870N9C14PyFrm71LTVkwfv4qK3pBDGEIbxUi
 4Fwk5vtPVx3qiNH3sqdSe9HNvSBBnZrRLVx6ztDdppBZS4s3+SZbR4OUb2NFhgkljWd6
 RodlrloyGKgzxmbMjb8DgiwryHvZPM2byrxQz79bRNWhOsrgfgT6GkRn0wrdtHN4oUXi
 /lkppURo+WJPjPIh0DTUy72IpoNov4cCg6+2dlKrzpASUXpgNHexpy+2PqhFRjvC6MEb
 jJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nDULy346PEO3X8rtIZa/6Q6sX3fxV7QSzcqOMFv73HI=;
 fh=DkEooEG7he3kAXG3TA9e4rdbNsIgMbuD3ROPyB6ao+c=;
 b=AtrgckgecAwuJ/CTufp/pLSZ/ywDtdRko4CY5EAGlCVUOrRdsgbrBMjqpgw1P0ZRUx
 DUmghmf6rVcRSerw3efF8FJE1TLX2D8x6w1IFvEw6UIVynAi/Ik5Iu4FcydCTsAWDisj
 aL+iy8GkFYf6RNC7p9Y+xMSw8pl/qavpx7Hb8m2BDWljIEdzD40olPneJD3jT3Ks+8KZ
 a9J0p4xslCLVdQJPwErcd2+Kj5P7atuWIB87Sa+kESiWzC4gXYpvFtoaHPkcTDJXUmIN
 aN6g2spBkVGu0Kg2vDpqBZMdHW80Qia06TZ7mGgyahvEDc3qJfqsv14grPtTRd7FjWOa
 gvWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488112; x=1790092912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nDULy346PEO3X8rtIZa/6Q6sX3fxV7QSzcqOMFv73HI=;
 b=e8n/JU2r+3BdAJTNpMgKqWWqD1/4gwfYeW8mbYeT6o72YZb09lnkJV5zilJfg0IZEg
 h0lCOYSrCcA+x16qIIcH62N3g9MrTZJ18ACNpXziVAebqIcqQVcwx91YU+wkmFqxeia6
 MA4pU3vIzyeaL/cMjMAGVIfid2wsvX3ak9zVWwfWQGfyOFEldlVqpo2NB88qdhFv6yhN
 t3wRhTy2Pl8Wic1BE9hSz8hDQ6fI8O9hk9vM4GWABDMgOpu0C8dP7+n5pxbcIupG6zDB
 G2hjD01gurRzZd2ci7/JU9xw9hoNx1ZYyIWcsUQLL+leSQ3uA0DTuadGnP9WCy6KEfde
 kNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488112; x=1790092912;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nDULy346PEO3X8rtIZa/6Q6sX3fxV7QSzcqOMFv73HI=;
 b=dZGXV5U6xTfPP8FhWpEOTL+n60AREPGjN+tkFv1ovYAjZ9pEVxHc6SRw+JZsALufFF
 4MVXC9SueGS7hPSgPhCyqZUYT8xTI/1n1BnhyH0eKrjfLh31uChS74uW9QLPsQDAYdEd
 iCLzUFCsjry+kZPPdbb3tU6EPHUJI22koJzZPPrvlkXLZ2fQXmmI/NPCevBOxSmxwDn+
 ha77FiA1viih2vHsXHZ+NyufGu399rzgVgckNXeXl5aVnMv1kYkH1BkCn2jPPxSka9l3
 f2EzvOIgLFxVs9ZiO7dUELtAWgpoJjyCEVc9HGKX4hjOuPlA/qvEgFTvrcGSODbfi0l5
 Afcg==
X-Gm-Message-State: AFuF++kJmdIrG0urBdwVOJdgXoqxta+6t9nVuuh77OhTATQHUmL+oxA7
 ZeO/dekgxgSKnXayXxwOSJqvVFmxprFXNZNLX1Vgo9EVcNbWCwoCqdcKNGSw5225Rk1EQ6RZHhk
 jAdetlTJoIr+FKfcJwyE48ezdNA2msVg=
X-Gm-Gg: AYBFou0ReT/5JSNsmnTdIGOQiZ9/Crjg1vKBbkexa2ufM680GScg5BABzdVi7szywUL
 YJF3ZyDgK7kLcorVD1b4qlimuqHVRcTaN0njuxzN4QDqLd5gVcVgkAnwBQyu5XAI3fvuSFjlyPG
 Icn+fA3OMpIlPyHcucvzkbZ84/WStYd44AjrYvlMYXfFOxFlqmxd9MhD0JwbF6mWuwnod1xyEPk
 ovOIYfAJXJETqqTbk5qO5kLOTv8ul1DmV4oUwsomV0TZtk/270y42aP5X58BaU4Yl5TJATRXSu6
 bLnnvogHEch+SMEJSbbsTCWW0nXsQI5C1Zaps9SG+LTm1+0GwJ4Ms6HBx7xBpfshddl9z8n/ujG
 k3hYt9dCYnic=
X-Received: by 2002:a17:90b:4a92:b0:398:9beb:a2b9 with SMTP id
 98e67ed59e1d1-39dfe1ca2dbmr6800524a91.27.1789488112303; Tue, 15 Sep 2026
 09:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260915153326.90014-1-stefanha@redhat.com>
In-Reply-To: <20260915153326.90014-1-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Sep 2026 20:01:39 +0400
X-Gm-Features: AcwNN1W0v9C71d20ebY7vLHblXcXCpB5IetL8sjbQ6jD8Tu8ZoNRP2YiA1IYKPI
Message-ID: <CAJ+F1CLs2OyGeRZLnxshXLzpNF+tU9=0MQC__UEFVzPcXR5qtg@mail.gmail.com>
Subject: Re: [qemu-web PATCH] Add GSoC 2026 wrap-up post
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Tanish Desai <tanishdesai37@gmail.com>, 
 Aadeshveer Singh <aadeshveer07@gmail.com>, i@uchout.moe, niko.ramak@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 15, 2026 at 7:34=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Google Summer of Code 2026 has completed and it's time to showcase the
> projects that QEMU's 4 contributors worked on this summer.
>
> Cc: Tanish Desai <tanishdesai37@gmail.com>
> Cc: Aadeshveer Singh <aadeshveer07@gmail.com>
> Cc: i@uchout.moe
> Cc: niko.ramak@gmail.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks all!

> ---
> Aadeshveer, Nicola, Tanish, and uchouT: Feel free to suggest edits!
>
>  _posts/2026-09-15-gsoc-2026-wrap-up.md | 96 ++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 _posts/2026-09-15-gsoc-2026-wrap-up.md
>
> diff --git a/_posts/2026-09-15-gsoc-2026-wrap-up.md b/_posts/2026-09-15-g=
soc-2026-wrap-up.md
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
> +Code](https://summerofcode.withgoogle.com/) 2026 with 4 contributors wor=
king on
> +open source internships from May through August. The contributors gained
> +experience in open source software development working on 12-week projec=
ts.
> +
> +This post covers the GSoC projects that QEMU had this summer.
> +
> +## Fast Snapshot Load in QEMU (Aadeshveer Singh)
> +When virtual machine snapshots are loaded by QEMU, the entire contents o=
f RAM
> +and all device state is loaded before the virtual machine can start exec=
uting.
> +A lazy approach is actually possible where the contents of RAM are loade=
d
> +on-demand when accessed by the virtual machine. This can significantly s=
peed up
> +snapshot load times since virtual machines may have a large amount of RA=
M and
> +loading it upfront takes time.
> +
> +Aadeshveer implemented fast snapshot load by taking advantage of QEMU's
> +postcopy migration infrastructure, which monitors RAM accesses using Lin=
ux
> +userfaultfd(2) so that memory pages can be populated on-demand. A thread=
 is
> +introduced to load RAM in the background while the virtual machine is al=
ready
> +running so that on-demand loading is minimized (it affects virtual machi=
ne
> +performance). Testing showed that fast snapshot load indeed provides a m=
ajor
> +speed up.
> +
> +Aadeshveer has written up a [project
> +report](https://gist.github.com/Aadeshveer/6a16579aed93f5d483bbb9419ecd2=
211) as
> +well as a [detailed
> +journal](https://aadeshveer.bearblog.dev/a-summer-with-qemu/) if you wou=
ld like
> +to learn more. This project was mentored by Peter Xu.
> +
> +## Support x86 Process Context Identifiers (PCID) in COCONUT-SVSM (Tanis=
h Desai)
> +Process Context Identifiers are an x86 CPU feature that improves context
> +switching performance. Without PCID, software has to flush the Translati=
on
> +Lookaside Buffer (TLB) when context switching so that memory translation=
s that
> +are no longer relevant in the new context are no longer used. PCID allow=
s
> +translations from multiple address spaces (contexts) to exist in the TLB=
 and
> +this can help if they are needed again in the near future.
> +
> +Tanish implemented PCID support in COCONUT-SVSM, software used by confid=
ential
> +virtual machines. This involved:
> +1. Creating a [Rust crate for x86 CPUID feature descriptors](https://git=
hub.com/coconut-svsm/cpufeature) so that PCID functionality can be detected=
.
> +1. Adding a PCID to each address space, including writing a bitmap alloc=
ator for the available 4,096 PCIDs.
> +
> +Tanish described this in more detail
> +[here](https://tanish111.github.io/tanishd/blog.html). This project was
> +mentored by Luigi Leonardi and J=C3=B6rg R=C3=B6del.
> +
> +## Observability Support for COCONUT-SVSM (Nicola Ramacciotti)
> +Troubleshooting confidential virtual machines can be challenging because=
 the
> +host is untrusted and does not have visibility into logs, traces, etc fr=
om
> +inside the virtual machine. Instead, an operating system running inside =
the
> +confidential virtual machine could extract logs and the new Observabilit=
y and
> +Configuration Protocol (OCP) has been defined for this purpose.
> +
> +Nicola implemented OCP in COCONUT-SVSM, creating the interface that soft=
ware
> +inside the guest can use to read logs. A Linux device driver was also
> +implemented together with a userspace utility called svsm-tools that exp=
oses
> +OCP functionality to list, read, and write data.
> +
> +Nicola published a project report that goes into detail
> +[here](https://github.com/n-ramacciotti/GSoC-2026-ocp-svsm). This projec=
t was
> +mentored by Stefano Garzarella, Gerd Hoffmann, and Joerg Roedel.
> +
> +## USB Device Redirection for qemu-rdp (uchouT)
> +qemu-rdp provides Remote Desktop Protocol functionality via QEMU's
> +org.qemu.Display1 D-Bus interface so that the display, keyboard, mouse, =
and
> +other devices can be forwarded from a client to a virtual machine. USB
> +redirection is a missing feature that would allow USB devices to be plug=
ged in
> +on the client and attached remotely to the virtual machine.
> +
> +uchouT implemented support for QEMU's `-device usb-redir` in qemu-rdp an=
d
> +integrated with the RDP protocol's URBDRC feature for tunneling USB traf=
fic. In
> +the course of doing this, uchouT also contributed to the IronRDP Rust
> +implementation of RDP (qemu-rdp is built on top of it) and FreeRDP (an R=
DP
> +client).
> +
> +uchouT covered this project in detail
> +[here](https://uchout.moe/posts/gsoc-2026-final/). This project was ment=
ored by
> +Marc-Andr=C3=A9 Lureau.
> +
> +## Conclusion
> +Google Summer of Code brings together talented contributors who would li=
ke to
> +participate in open source with mentors from established open source pro=
jects.
> +Thanks to Google's funding, our contributors were able to dedicate their=
 time
> +this summer to implementing these features for QEMU and its ecosystem. W=
e hope
> +to continue to see Aadeshveer, Tanish, Nicola, and uchouT in the open so=
urce
> +community.
> +
> +If you are interested in applying to future rounds of Google Summer of C=
ode,
> +keep an eye on the [GSoC website](https://summerofcode.withgoogle.com/) =
for
> +announcements and timelines.
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

