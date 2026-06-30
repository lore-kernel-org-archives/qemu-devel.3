Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C60C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaub-0001Mk-CI; Tue, 30 Jun 2026 12:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1weauP-0001EC-MP
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 12:02:05 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1weauO-0001bG-4K
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 12:02:01 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-698439b6e8aso7036475a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 09:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782835318; cv=none;
 d=google.com; s=arc-20260327;
 b=bdehRE9lK8J63W0ncOjiGZVe20lMhog06qJolW1iinQeErAg5ib1gQ9HExqWxtP9DH
 MC4xuKNXahBtM0gkrlyylFR74r8Vs1zemRFdvIgc+rBdPW236Xlpmp1HrsnjxnKWFd01
 GgEadSuz5b4LIwX/Wjqo7TkEwbpIH0BDPsD3n67D9V6KKAWAZjQdJzZYWbjV1BudFSG7
 kytl4arGLetomqRCug/3umrMKPyjUab/3X6VmZf8glArUZ77tgl8Zzc8Kq86h5inq00G
 sLqemWCsT+5RXM9k1Hpf3AX0+58D3/kftAmG4LvV6410VpvKBKmdPu8Q+iUWlQ0l3vRg
 raOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FMDZ/9LcwVWfRMwuqDJk3mRA0hydM1gILSmaed15x/Q=;
 fh=iva+ciLj+a6kUP3//qR6yQbSLiUW0bFXP9odkvOKeso=;
 b=QC7Dl2oHDz0W8P0lC6Z70LvXaoqYZJ3VREv2m2k2gSAw8H+CQ/kakrZYnLq2iez5il
 UGYbvMm3zh5DOdAf/xCUE0KhMUz4L4CXsAu07fecGRveBK/WUrdOLC1ABmxXT5yGJLUq
 +1ofENFduASDN75KhamY2Eys555e8MibUiBHlvKtWfAqc5Bs98wEh7H4K/8QgN++Yzy9
 1Gw7zkGuRDemFvPv2s0wiIX1TOqpicVgLyVRp4UQLiYFppKYGXXdI2Jvrfklo+qwIJts
 XL/xN3D55/UmWvsPDyDPGxnf8WCGrUBQXVouITR0BTbJj5qCa3HSJeZnckkSWuW/j3zP
 xFNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782835318; x=1783440118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMDZ/9LcwVWfRMwuqDJk3mRA0hydM1gILSmaed15x/Q=;
 b=J3AI//VdUmEvjgEJu9U822ua3+gdyIDgZO0ApZ4ujxWO8eZkpswBgXedY5UipMsr4j
 Jr6jm7aHAMKXrlpGAEsEz3deB8NfJA5WV45MWeNS5mnOQdhVptvfu1mUua4VpdpD+hA5
 UnPO+KaCgyj1twf32jHj7g49vW+Rn1cSpcHVA4xHr8JO48YyHZWzQ+eVAKrsLmjx4pHv
 5yliRp8hgob9bs/1CJODrhitvaUs8fatK8Z9SLePnaGTGmK5C0A/bATe/2zAL9CzSRW8
 gObkWWmzxBs/osjy8l1WHNIuiM5CTT1AxTwi+/SPRkBbYVX54gn0qfY3SJaHlGO9On9e
 4G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782835318; x=1783440118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FMDZ/9LcwVWfRMwuqDJk3mRA0hydM1gILSmaed15x/Q=;
 b=WKKgaH5cFO1kLvYlxe7DLtOT0X2LxoGYFGUXjFcwYi5I2mtvIlwZOfPXuxjoNwv7rt
 zYS1+20DxBZdIVrYFqD0FW1KkEeOyhLTMPn3N09lYtLfLjPXCwfA+dvp9HcbilUu9KBT
 jfscwxEjLHXFQ1lFlrkSASnXDJiKLptOBBesaYkla+VEPJ3bFZ//cUOQmCgKGDqu8W5H
 qdF5Hxsi8vrVJb4q9OOJlB8HYK7oQjtqg0PqgF4gq5AoZ/U07pmcSaT4jIo0Mdppj7iS
 8Gk0D1l/hsEnEVadt8+UotJu3U2Y9qWgR6ZtVIqFBGy4Ky4XqK7QBERGYXce3mPpF+rM
 1djA==
X-Gm-Message-State: AOJu0YyCxAqsSw39SfNjjfsiz8h+nng5+NHYVQ+/6hKZiGJJk3WUjtiw
 oSGhg0OJ2/z+xMq8VN4juTXX3VtgSjqBlfvRYhAbUdFglc4IXEAOrZewIOCkd/5Y9X3sH0cP22I
 1NIMbThcsAhpIjHhNAciBeKID7/vxOU8=
X-Gm-Gg: AfdE7cnfE4QyTvjKoB28Tyh2p6kn83Ju3zSUSCSglYUX+4dkYVH7VqYDjX4KY3nCTNU
 DNvYsMDjHRmmbRtZim4VADHrw6Nqjwo+gYfPAEpIl/YMWn5qYzflGVX3OXzoFSQD7vMDwQ/vTur
 xDFcqGttKqBwnGGi/V7jTyKdziQFJoLCsBv+8i73Aqo6IzfZCK6tGjgoAYkPzgAnm/vFct+cUaM
 mZ3HavzOZfWfE00vtRtdGgNJNG/I9XUlGHbbwDBXSk76YUAGi23jwhtXOWhiQxXYRT40Ld/csBh
 kINCpqsWPsq+x9KaJ+bMahw3HCwNB7ty0pbBKhKZgtJGc6VxeFYDy+wVpQ==
X-Received: by 2002:a05:6402:3784:b0:695:b02f:e9bf with SMTP id
 4fb4d7f45d1cf-69887891cf3mr653257a12.25.1782835317652; Tue, 30 Jun 2026
 09:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
In-Reply-To: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jun 2026 18:01:44 +0200
X-Gm-Features: AVVi8Cc6rJxICS9Ev2x2vQXWeZouDrPQjKOKkaVhXDj91xuTMAHwkqZKZ8Ji3EE
Message-ID: <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
Subject: Re: new roms/ content for hexagon: h2
To: Brian Cain <bcain@quicinc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Sun, Jun 28, 2026 at 9:46=E2=80=AFPM Brian Cain <bcain@quicinc.com> wrot=
e:
> I'm working on upstreaming support for hexagon system emulation and it'd =
be useful to add the h2 vmm to QEMU's roms/ in order to simplify booting OS=
s like Linux.
>
> To that end, I think the initial step in the process is to mirror the rep=
o in the qemu-project?  https://github.com/qualcomm/hexagon-hypervisor/ is =
where the code is hosted now.  And once that is done I suppose I would add =
QEMU patches to add the build process and build output into roms/.  Can one=
 of you do that mirror step or suggest how I can do it?

Hi Brian,
I have created a mirror of the stable branch here:
https://gitlab.com/qemu-project/hexagon-hypervisor

Please take a look and let me know if you need any changes.

Thanks,
Stefan

