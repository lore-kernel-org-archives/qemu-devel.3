Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EE1E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHtw-00070m-Qy; Tue, 03 Feb 2026 10:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nassouli@redhat.com>)
 id 1vnDaZ-0002qp-Fb
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:24:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nassouli@redhat.com>)
 id 1vnDaX-0000Jj-5i
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770114291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=n7+8yOF06gbm/dDSdi8hhHB+wUZdffnhaGkeB3NHATY=;
 b=h1vse20dXWNU1Kqy2lPYGCqQOp1S4mKrge/OdGwQ8Lxz3NlgokKpUU4sEfHqb5iwzJungp
 85dcxORQbwfz4oE3Z4gvKHVSo2BbOa3wd68l+p4tVVUwZujbMLJZjd3FvvmKvv+0h+9Uca
 d2NdxU4iW0TsZ/eGAsmPGO+QaAdNN3g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-LuEAH9xsNBeHZKrrN13XzA-1; Tue, 03 Feb 2026 05:23:42 -0500
X-MC-Unique: LuEAH9xsNBeHZKrrN13XzA-1
X-Mimecast-MFC-AGG-ID: LuEAH9xsNBeHZKrrN13XzA_1770114221
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59dd7edf3e1so420726e87.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 02:23:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770114220; cv=none;
 d=google.com; s=arc-20240605;
 b=KJOsoEXAIu7PR53S2LZTM4POLtkEgS+SfHvXoi/GFtrx4gRWLCKkKGnLizjAqCw7tL
 +rwV6Rpi/A34pdt3Cy2Oa7+lNWLq8faGUN/FR8Jf1jT2Fyd+Qje2i5fKfM3NaBTLfJLJ
 llXlgQ9bZ9Cd9yI4nzTFfDSPuttRVvHD8oYBbq9iJEXBL0/GJRC+7h2Ncdo2ufgf2ZBP
 F/y6rzaYVvLuk+5ZKKkzjhgv7ymfzLVZnLMDnDmGRhXd+64Gfobjhj2ibAEzfWJgsIGI
 oQuaVTh4fHlXOv63/0wATJePeuDU0sF0SA6mWkxsNgy3mqzPnG6aO5ntHsdQwcMY7WKN
 oK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=n7+8yOF06gbm/dDSdi8hhHB+wUZdffnhaGkeB3NHATY=;
 fh=k5L7ghkSTNizXKm2wlOYLS9Iwep7IDhQo2qlyWo6lPc=;
 b=gNXd9YaecFvBdVNeDa3/6/LSAAaYQ4bJmNSYJf3ZDBmWMWKyGIkNDii9PeotjNQ+3/
 6hSoa2GlV0VnszLfkT3ZIpH62zTjmcx9mqxL83wA1jNwvsnox02LR32Qp2JcwjJ3oCe2
 cqzfPOuF7OrffEntZZkMHHlWbH81YbRIc0Dq+QwTDLZAkAeE/IZQGq131ZwHiqttT7PQ
 oKgOnT2iwntqAdjvEoq+3yPH0R7B+cybxBKdmNrapzkbkDrflA3jjmyQQq2zOKhYCSay
 tU70sqxIA6yLpTK54uBn+QJVR4en8JF8s55Ma4Ind3duEr7W6+Mli8RmU56ktjGCPHti
 IC2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770114220; x=1770719020; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n7+8yOF06gbm/dDSdi8hhHB+wUZdffnhaGkeB3NHATY=;
 b=f/621NQb9JO0yY5wtyrlD3c5kDLCOEcPL8vqx51jgw2XKYm6jFmVaGuEMD4YdT1LZX
 rM/2vv8EL/WW8cz1ghfbBVmV44y1Pj0PdAv39lQHLj1aaD/7FcT4RbFcPTQ4p1u8/rWV
 Y/9JPst+UAWnWT8sJ9/RXrxvp98qd2oK1AeZ1ByjdJ6l8Wte8sIqdM1WyIBaLzmwPEIh
 3oD/WSmJKKaOGAZmXenMd2xc8k2fbvfIzkKV8P3hTtaLkoEUXUPmT0D7HKr//W6d97dg
 TcY2yNc2ZrMz35ou99MuWig+kWjpzNinxj02ZY7WFJiniUoPOt44cW01DUqo6YRqVGBz
 8ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770114220; x=1770719020;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n7+8yOF06gbm/dDSdi8hhHB+wUZdffnhaGkeB3NHATY=;
 b=YWkuBrld7h59imjiJ5UUinaAu8lM+9AJwXT4ROCoC8U057X9olezt94tbhNXebz44z
 +OMyjTGbkaRluYHbvQdyry6h0p+sygubX/EKvD15ZWiw6RjqZJAv1+LIms6G+XLbUwbM
 iDlBLS6S9RUtSjO1DXvGcccgR5383f2XuzjqJ+znZKqLHLz4wMNSP7jBQYHsc403sBdP
 cR0Frw8FWiOOMLtdB2fMnulUgYpXLN6sYP1NUF61/p5Ux6ZswZQU/K/MWgoqhbyPcqcJ
 9G90HgPeYfwVLyUn9mxQh2OTe2VnDT0lcrWxg02L3h0KiGnoic+dqJ2V0him8qiFhjl+
 Ntog==
X-Gm-Message-State: AOJu0YzLz+ak1/RnTAaAXv6xSZJcSsMbdPrBpL4RWSUFSaPdROvJ4ZQm
 5IcSkRpz/YIcUj8nA6xWpEHwz+8/7qhaJ0XFRLPm5vQy4CJdzzeROL4/wOZx3ql+27eSra837eY
 O4hdM6G/rOWa333zCYR+K1QF/U92h3wzhjDggucNNK4L8kbXEyKnn5mpjvzE4bLWh3QUVBGYRmY
 tX993z2RJqJmJfbKeWUpIj+zFljvYvY9ylIhbS8QYQdg==
X-Gm-Gg: AZuq6aK973IHJNhTSraw8oKcGO5tSpp7NGHRmG51lh5V8hPvxZtoZLitr6b5OuBhN7Y
 jeCBTq9yXPEzC3AcRRD1rnTugWpaShnxL/0VXvZNHusPLIk9KWaEJsQUUXqbdwK8fAnsSfB6Cur
 5tvaNeF/Q0B3FFxKvm7i7IHDdk6+LBkCS4/yJO7KQMzvk2W6HMz4ZPGntEx9x0ZiJ4ptHqoG4GN
 u09wX4d+NpzuRkRp2C0w1JO/dNG
X-Received: by 2002:a05:651c:1991:b0:37a:5ae5:a1d2 with SMTP id
 38308e7fff4ca-386466b5a20mr28769201fa.5.1770114220043; 
 Tue, 03 Feb 2026 02:23:40 -0800 (PST)
X-Received: by 2002:a05:651c:1991:b0:37a:5ae5:a1d2 with SMTP id
 38308e7fff4ca-386466b5a20mr28769071fa.5.1770114219565; Tue, 03 Feb 2026
 02:23:39 -0800 (PST)
MIME-Version: 1.0
From: Noam Assouline <nassouli@redhat.com>
Date: Tue, 3 Feb 2026 12:23:28 +0200
X-Gm-Features: AZwV_Qj5_OMFlkfvP_ioeTcLi-3r8LspgdPFgqJu_RrNf_RABcvsPNcH5BPczrE
Message-ID: <CANc8XmBVnkbrsJ+DMKXA7HhepStAPHRpXOH8fB16e=bghPOsqQ@mail.gmail.com>
Subject: QGA fsfreeze blocks QMP: need async fsfreeze or alternative?
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Stefan Hajnoczi <shajnocz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000044f6b70649e8d56c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nassouli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Feb 2026 10:01:05 -0500
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

--00000000000044f6b70649e8d56c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello qemu-devel!

I=E2=80=99m working on a KubeVirt fix for Windows VSS fsfreeze timeouts (PR=
 #16653
<https://github.com/kubevirt/kubevirt/pull/16653>). Up to now we=E2=80=99ve=
 relied
on libvirt=E2=80=99s default QEMU agent response timeout of 5 seconds, and =
that
often isn=E2=80=99t enough for VSS fsfreeze to complete. This PR proposes
increasing the timeout to 60 seconds so the freeze can finish successfully.

The challenge and the reason for this email is that qemu-ga processes
commands synchronously on a single connection. While guest-fsfreeze-freeze
is running, the agent is effectively busy and other commands (e.g. ping,
status) will hang until it returns, which can impact pod readiness probes.
I=E2=80=99m checking what we can do about this.

I=E2=80=99m mainly looking to understand whether this can be addressed in q=
emu-ga,
and to get guidance on the right direction. Is there a supported way to use
multiple agent connections/channels, or is an async guest-fsfreeze-freeze
with a completion event the more appropriate solution? More generally, any
best=E2=80=91practice guidance around Windows fsfreeze timeouts and respons=
iveness
would be very helpful!

Thanks in advance, and cc=E2=80=99ing qemu-ga maintainers.

Noam
KubeVirt Storage Ecosystem team

--00000000000044f6b70649e8d56c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello qemu-devel!<br><br>I=E2=80=99m working on a KubeVirt=
 fix for Windows VSS fsfreeze timeouts (<a href=3D"https://github.com/kubev=
irt/kubevirt/pull/16653">PR #16653</a>). Up to now we=E2=80=99ve relied on =
libvirt=E2=80=99s default QEMU agent response timeout of 5 seconds, and tha=
t often isn=E2=80=99t enough for VSS fsfreeze to complete. This PR proposes=
 increasing the timeout to 60 seconds so the freeze can finish successfully=
.<br><br>The challenge and the reason for this email is that qemu-ga proces=
ses commands synchronously on a single connection. While guest-fsfreeze-fre=
eze is running, the agent is effectively busy and other commands (e.g. ping=
, status) will hang until it returns, which can impact pod readiness probes=
. I=E2=80=99m checking what we can do about this.<br><br>I=E2=80=99m mainly=
 looking to understand whether this can be addressed in qemu-ga, and to get=
 guidance on the right direction. Is there a supported way to use multiple =
agent connections/channels, or is an async guest-fsfreeze-freeze with a com=
pletion event the more appropriate solution? More generally, any best=E2=80=
=91practice guidance around Windows fsfreeze timeouts and responsiveness wo=
uld be very helpful!<br><br>Thanks in advance, and cc=E2=80=99ing qemu-ga m=
aintainers.<br><br>Noam<br>KubeVirt Storage Ecosystem team</div>

--00000000000044f6b70649e8d56c--


