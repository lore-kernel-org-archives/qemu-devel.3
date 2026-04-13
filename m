Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59151F34C54
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHpX-0007uY-2i; Mon, 13 Apr 2026 09:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCHpQ-0007qr-QJ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:59:53 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCHpO-0004wc-Jd
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:59:52 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6501d242e3fso3898975d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 06:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776088789; cv=none;
 d=google.com; s=arc-20240605;
 b=CHhXD6d0g8wCfMkg+b4tpZQb4cJ9/0yWfA5o9VHpeCT97IqU94gbiWpo9h2GXe9TXa
 J77iQUDlnd63HDwLrjc2IroVj+MuiCZgXXuk+ZuPEQXQ76jG1vrHyWU8fIYEM05Q9KsT
 vAB/Lyl4bARzVR7X+fKiQI2nzc5oQC/vtp/2QMIF53ZnS+ABEhRWcXgYR3vO7x8vuP/u
 c0HaW9Au2DHyIgF2/JOmbuYxoyvWWWSVxT8EdyhNrBh2yRTOkfteNrNdTxeY2RsR11K5
 ATynES8HuSKI7xESpT8HFGn24+sLD0G1z46nk+mLQzTtxxHGIIUOzYIU8R/0u3oSDztb
 LSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FC7chCUPQmLp9ToarZO5ZTCRLfT2LzlBj6z9d1rhzUc=;
 fh=jTICRZQonhXnGZ6zW6ALtQubEH3CyhSroXRZicteSfI=;
 b=foaDiGfaOR4G7ACObcZH82JwtB046YqFXX+IZe0HxY/XrPS0NT1YLKSLC4PaU95Cz8
 UCO1RaRD2oz7kOHBgsXdLFCF/bI2tE4gxckfu7k2BPxox7w3A6TwQ9k5btvlkSTLF7Ua
 Ivlnx5qgS3Y2MKBsaeI6CDN/edAPx1vputv0vlqa08QY5N096ziuDV5FhkzagP2Jl4+b
 450kTr01OsKvnylBf1cctg9UVN2dDZbEi+taJiyMGq2qKFAa03OYTME0e8dNaojye87g
 XyfiySpYo7AH79NTS0yHFqvKe+dEYgoVG7Lf8+FviekdDeSF1bM4RhnlMtEKqbRL6yqi
 nd7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776088789; x=1776693589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FC7chCUPQmLp9ToarZO5ZTCRLfT2LzlBj6z9d1rhzUc=;
 b=fitvXvJVwKbNBQQItkiZ0pRzRbsCrdt2uw3KXxLYjEB61/TJDsgb/EjvxINBTMvtVI
 xOH01nFXm+qM102xVmwvrJDFUjMyxF0kvjvdlgGEoZgCuFKT6eiy59zFa48IzrBPfcjo
 3VJpC7n0ImQa14M4WEYI+Gnq8xmW5N8YOwZ1KsLyte8eExg8fRr709Qv3wtvy4+nUgQU
 EpJ6V3SEsqIhZ8gL0u5aWezcKu7BCjc47tTQ2xUF8jTC8stO/mJmN997w5Jw98OLHc6J
 1mJAIiacIwXHUB3LYo+sptD8ceQiK6i9YjdXaOfbjlZZcYHfqEDXYu4nLXYKWd1JExej
 xGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776088789; x=1776693589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FC7chCUPQmLp9ToarZO5ZTCRLfT2LzlBj6z9d1rhzUc=;
 b=J1qj3HXh4Wcqw4sSyb8QQO7tr9GqNqC72jKIqMmaWQgEdqWx2SAJe6K7CQfZzgV/VR
 XeQe27xSj6OX7Pz7MO4WdRvkA8uDGKv2SDK1+if6eVPx5/oNA/Rw2FYGY5oBPLEyu3V+
 1Fq4XzTkrvwR0L9fA2M7SbszR+JojG+X4kJfqXQwRZkMvmXGDXD3VL2JdBy/vQ/Mj+nJ
 ZZsnkPDd+T7j5khlkDhCsRLnJ1k2Pqg4eQHe7raUWTFDFzwD+JpCOw4oTJ0KF53m0eiY
 Gl60WEe7/6/ToA379/H1VW1XUdDCznUdY82smjTSS+pYHOiWSpGnPusVHslS7JQaGyv7
 eZgw==
X-Gm-Message-State: AOJu0YzVMJPDljZpyc2pScpE//GEP4UczY6tpsHX9aiRJycco4XrnMGG
 49vVmAlFrmuHCbDtyunJ0sVLNy5KLRM26xSx2j9UsBasUUJ/wfeqodvpMnAWXj0pWpekV3phPGj
 tr0GLFkdzEwK7x3bkRO4H2Go3thE6ZyYlUaJ7bl/toQ==
X-Gm-Gg: AeBDieu8otXaJwGDAI1FQ8HoXBtX0jSBplF1l/SstZwvOI9bnWxwb+zhMdXtFuPROgJ
 BDWjluAAxh/+BI9+f1MyA2/r0DLuVLByQNXl+hDe+gsfN+Co8KxXCK5az0Ct44IncpGE3SdAqJJ
 UfMFLtBmQnunwtnE3S8cj8pa1/TdemyptMHsnXeHgYDqjlakRu3ahT5pfAH+l7WI9AWNbHUP7Yf
 p0YduCrvbJg5iHTttp7m67QNBPqImSUi79CdyII4uXUPE8G7Sykzp0C2/eW+qzitWuDvqgVnG+W
 7r3bYq08d51OwH0KCWcZtvUFmKC44ryzv/LnmS7HcnOl+BAR7JyAKXZwqv4JCE1U8Mg=
X-Received: by 2002:a05:690e:130a:b0:650:95e:2fc with SMTP id
 956f58d0204a3-65198b566f5mr13463038d50.40.1776088788483; Mon, 13 Apr 2026
 06:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260413130748.6631-1-philmd@linaro.org>
In-Reply-To: <20260413130748.6631-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 14:59:36 +0100
X-Gm-Features: AQROBzCDwzLgc15qiZaGD4UfBESj_wEp4vFWYc6qeHUe0mEMwtIRDqisrtAIZvQ
Message-ID: <CAFEAcA8LPMQnTk8PMS81FwRG+2yX=ScLc+6TtZzNqUJn9yAszA@mail.gmail.com>
Subject: Re: [PATCH-for-11.0?] target/i386: Mandate monitor 'info lapic' take
 a vCPU ID argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 13 Apr 2026 at 14:08, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> With SMP configurations, using the 'current vCPU' under the
> monitor isn't recommended, as it changes during runtime. Better
> to specify which vCPU we want to monitor by its index. Deprecate
> the default of 'info lapic', mentioning an argument is expected,
> so we can remove this unpredictable behavior one day.

Is this really "unpredictable" ? This isn't the "current CPU" in
the sense of "whatever is currently running", it's the "current CPU"
in the sense of "whatever the user has set via the 'cpu' HMP command".

You can certainly argue that a UI where you set the CPU via one
command and then that's an implicit argument to various other
commands is not ideal, but it's not unpredictable. The
only time the CPU will change without user interaction is if
they have set the monitor's current-CPU to one that is hot-unplugged
(in which case it will reset to the first CPU), but the user is
also likely to be in control of hot-unplug events anyway.

-- PMM

