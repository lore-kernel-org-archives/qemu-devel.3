Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364C2D262A7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJXD-000604-Fm; Tue, 20 Jan 2026 16:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1viJXA-0005yr-8I
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:45:08 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1viJX8-0001Qi-Gv
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:45:08 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65813e3bdaaso355277a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 13:45:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768945505; cv=none;
 d=google.com; s=arc-20240605;
 b=a8G4Oh37MbTWycZQolhRFmVx5Zl3xZBw+elSzUTc34N5XzvTh/ngghqhszPC625drM
 uh0xSo1wDxGhlAeUZnrCVwip4ubP00q9drErCfVvfciJamAzX10H2V086oBtv4bjl2z6
 gX8npNtexuM7lpj2xkQRF8jneCKP0rqCSZsA6lm/oMMjHe+PMnxZSW9+PjmpKjVcQvck
 DTz4uas5JepyuB8PnO3vsHPOs7vce6RFOCYyTGIABxjOHLxBp7Ep0KmdcgBR/HP7mSM6
 YRtXAwXluyfWUxmgGse4Gqq1Yn/QBmJL51p3SUYce2EubGUUcJ1LaYbR3DXSqeGUVCHE
 GQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wuCVfUPWIgiHPOiSZst2gWx1Ux871B7BayzTg87bd3o=;
 fh=VYEkjaRvKTlpgb2UNe28qSxc6zsb6I8Qewcl9Pu5XHA=;
 b=HY9C3cWJ1O9mAZbi5aNkn5AdiuY9WMxRNue3d0sbopt9oez5Y33ctoDL8g+enMkKsL
 UJVCUvTC8r2my7bM9BTtJTh3/lFmpeC55QDsY+AhodakjyC1UcO462JMM+KfFAjtWpDG
 n1Bx9H5zy1N4iIXYrvqQ0JvpZfotkT+4sNVz61eXxBi5LSZhk4B5ldu1SiE9WmOCU5GQ
 m8v/MvrY3lQFVVUVNBkCPEDbFrLh9vE2otG4OIYb8T83zj57P660kRwk33fA4hbcV8HP
 JvAOiPeZfKNCqpBd5eMjSVkcCfShkAUvpkzbFiDO3gQKRlJ7RrjgMdq246DB5jfhujs1
 wBiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768945505; x=1769550305; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuCVfUPWIgiHPOiSZst2gWx1Ux871B7BayzTg87bd3o=;
 b=X+RTCcvWOKoTSivBLC3yYU4oBFyFh/o5xj0iu71O3Vh0RBqZnxhQjzyXSYAE2ZihP5
 4t2zxAJ/MRIv16SVzdGNxYq42OT0bupyNPA9/CI7W6A7GenZ8MkbBgNDp0illCVivv+3
 wQ1nyrADnxwcj7fVdKEFyATrctUsO13WcpU+zpkYeyevzRBWgEwsJ9AUl53CPH8pzx1u
 GW5yQ1CzcVSyq12IKjbybctw8X1rXK5w7l19aaMipk0yMHdwBpHQZNRvO1Ge/b4IEI9O
 qJ/z9tR9gLLo+bg7PNg5sNpO1JNKFrVNjuSeMsL0qbZigoP6ReEfHMjGWIWVvJciauxG
 6dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768945505; x=1769550305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wuCVfUPWIgiHPOiSZst2gWx1Ux871B7BayzTg87bd3o=;
 b=ZT6+xZ1Ga+p/JAaw66M/tDVWWw3nH2UZ5jTA+KHncjM4JH4qF7UCQdAoyzF6ET3Ms4
 fzIga8PIeS5Vmyk4mJZUZW3UrtS9d6AtrbBsSgzKye+APCR8BOdPrKl815k543KPL7o4
 c8a9RH2UJRLZ1k1WE3TzPH8fmY0xA4lrPs3/PhPQkByIrlIAwOPxDS6GQSJZrD2wJjpr
 kRQEinCB4gekX9/Jh9hiZBDGFyfUtfEp8CfAls4dcLFky68C+/xesGg5vxmvQCWhNZNe
 fr8GKzUFZlGu6zkIkuJqzGWf0T7EBMB+vz5z7zLVuXrbKbhsqwG5rPWKU7U7/RBhBKAh
 gqzQ==
X-Gm-Message-State: AOJu0YyXzM3cHy4qWtTiY9lHXXeX3HBfYYj7gy1R20ZXJhHOgt6DTQ+1
 mg8jRsUEafZfcett3nJg2SoYQSgowic7A3AKwn0UDiCFl+6JAfsqSVIxFUVUuFY83x0OnKxKhwa
 Y8CkvO++SMQNdQ6JfdYC2KgFb0FnCxRw=
X-Gm-Gg: AZuq6aJzu5nv0Gd+nSW37Jc18zv7CO7UAl2CG+xeoOyvH4K3veJkL00487WqGpzG/tG
 UsQz3vfqtsmKmv+z9tBd+K5b5xwcKhnUc/FYHTsYE/7BIP5bvxwmwBE480C7xKSTrbH0ZYFDafH
 R6m7USkk0wgSYEWQlE7CxKivzpXQsKEshuHUAZNXziallRqc+6aQjAJc6Vntvfk89CS3dpkiAIj
 wgJ8rv76dSuDvkzndgzkutHRC6lkklBGOXkO2LYjDk2/yPuqA7V/1BY0Lq8B2kJmhXn5KuANApB
 xFyw
X-Received: by 2002:a05:6402:35c3:b0:64d:4149:4924 with SMTP id
 4fb4d7f45d1cf-654529cf529mr14135804a12.4.1768945504621; Tue, 20 Jan 2026
 13:45:04 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
In-Reply-To: <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 20 Jan 2026 16:44:52 -0500
X-Gm-Features: AZwV_Qhh6g_HYOVxqiQtxYan6TAF-zvhLHQ20pLxk2ebb7UlLitz7roLdsUNLgk
Message-ID: <CAJSP0QVXzXL60S=4kdRGbLd-i5iNU4Ah2zr6iXzEFPHuA-pTyw@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

Hi Markus and Marc-Andr=C3=A9,
Any thoughts on the Marc-Andr=C3=A9's HMP internship project idea?

Markus: Would you like to co-mentor this project with Marc-Andr=C3=A9?

=3D=3D=3D External HMP Implementation via QMP =3D=3D=3D

'''Summary:''' Implement a standalone HMP-compatible monitor as an
external binary (Python or Rust) that communicates with QEMU
exclusively through QMP, enabling future decoupling of the built-in
HMP from QEMU core.

QEMU provides two monitor interfaces:
* '''QMP''' (QEMU Machine Protocol): A JSON-based machine-readable
protocol for programmatic control
* '''HMP''' (Human Monitor Protocol): A text-based interactive
interface for human operators

Currently, HMP is tightly integrated into QEMU, with commands defined
in `hmp-commands.hx` and `hmp-commands-info.hx`. Most HMP commands
already delegate to QMP internally (e.g., `hmp_quit()` calls
`qmp_quit()`), but HMP parsing, formatting, and command dispatch are
compiled into the QEMU binary.

This project aims to externalize HMP functionality, providing a
standalone tool that offers the same user experience while
communicating with QEMU purely through QMP.

'''Add `CONFIG_HMP` build option''':
* Create a new Meson configuration option to disable built-in HMP
* Allow QEMU to be built without HMP
* Facilitate testing of external HMP as a replacement

'''Create an external HMP implementation''' in Python or Rust that:
* Connects to QEMU via QMP socket
* Parses HMP command syntax and translates to QMP calls
* Formats QMP responses as human-readable HMP output
* Supports command completion and help text

'''Use `hmp-commands.hx` for code generation''':
* Parse the existing `.hx` files to extract command definitions
* Generate boilerplate code (command tables, argument parsing, help text)
* Produce a report of implemented vs. unimplemented commands
* Enable tracking of HMP/QMP parity

'''Identify and address QMP gaps''':
* Audit all HMP commands for QMP equivalents
* For critical missing commands, propose QAPI schema additions
* Document commands that cannot be externalized
* Provide patches or RFCs for missing QMP functionality

'''Future Work''' (out of scope):

* Seamless replacement of built-in HMP

'''Links:'''
* https://wiki.qemu.org/Documentation/QMP - QMP documentation
* https://wiki.qemu.org/Features/QAPI - QAPI schema system
* https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html - QMP referenc=
e
* https://www.qemu.org/docs/master/system/monitor.html - HMP documentation

'''Details:'''
* Skill level: intermediate
* Language: Python or Rust (student choice), with C for QMP gap patches
* Mentor: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> (elmarco on =
IRC)
* Markus?
* Suggested by: Marc-Andr=C3=A9 Lureau

Stefan

