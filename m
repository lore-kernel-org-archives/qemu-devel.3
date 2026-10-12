Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454D1CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGFU4-00044J-T8; Mon, 12 Oct 2026 08:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGFU0-000432-QD
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:50:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGFTz-0003Ih-Ac
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:50:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a02753c04fso9690405e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791809420; x=1792414220; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FQk5821yiMozkYNs19keeJKffhXwy5p2RBCrsgbicxg=;
 b=Y8gmi1jbDXr/gQzc1r04cttZkCKvtgKVVJZm2YhU2825bGJ3ABD0tdhwk9bdJbGcS/
 p2DM8zEy96vBKrK+kmwSXZwT1FKrW6p22EahfRzINvQyhX1k9HzeykUV19FoZFRnCxMh
 8DVs74rYFucrrwKFwjEEEP0cfeEdT0eOT5sQ7SOgvPvJKREPJzweh6zSkh2/l9xzpuJH
 54m10Jq1u77XWNDDiT3og70zcrYeSotY+bVbzrc17jme3v31oScHWGUfEyneQVuqmy15
 ONx1pGcclByZnwMOTJ73+mwTnNROcmmhWPHQDUV/IroqaXOyrGyOEZTlP1dG0ObhAgfA
 olUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791809420; x=1792414220;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FQk5821yiMozkYNs19keeJKffhXwy5p2RBCrsgbicxg=;
 b=w5yUyiyRoesaDBI6wDKr5E1CIHueEYwTP07sDpemCii7i8dibbw/+j+YuLD0uLQjSl
 Oy3w8CnYDtXm/kNl6wTwuPLTAKAZpgKGDeT8s4kOpEqrrETqe/9+vYheauc6MhXl15gu
 iBSecy479+auFGyxrUx3nwSOy2YQepFsUzkrEzlLhR0/bV0Ad/836Ftw65esmghMCBaE
 oACwGQr8D0fY5/gSKIevxr2HLKbLdtO6ZhJB4lnL2yzz2tOFoHWgqYuieUDrUEwVCQEv
 /spwfoIeaSvHWfaA9UHy6N2EuNfH8342+NUm5I0je1zbRecqD3XZu0pAswUwNdUhK6dT
 S4vg==
X-Gm-Message-State: AFq9FYIi4kazqV1hoHO2A1y+KQ8+0Io4+Vyczy/KhzlZM545VZ5R5mdV
 uPxddbLp/M/zqaPfx4CFaUzmU4F5Ps8L7vLhI7XQF0nhNljOgdt4KvNkeh0ZcN1R
X-Gm-Gg: AYBFou37xIy5iUceCoDjVsMOUy8VKDesou393K0UtYIpzehI0yP7i7MHcVCjPZPmOoj
 vsUb0N3P7dSOcYE9wrjMgfzeJh3h9JwZLlIBKBP9eH2rs04dZrpbg4LxQJVkSCalpWMsrK4lUA5
 C2E8wcpnlgS4v3VXvskYMQBYBw6ECibblKOTvbUIMr8bl9gApBZLapFOpSfQhxY5jeHJnlxsxMr
 H7+QsxdkJD4YHKUkMwuP3MLKzh7n2gu0zfU1tfHZWapIWzmb8CPYOF4nVpDBmFtS+rR7RyuSayj
 zwuRwR1VXGsOjSTWzUAJJLf51leV4rP1gSpXK2aGqFJhavpXaLfMSmreATg1rZhKwFtsCJbUI7G
 eO1MbvZm8hFx6tsWDZfHxal5VvDdipqG14s37a3sawrOLs6lpvnv2GtR3hTldNJm57odYcEDPX+
 n9wm6WvFCGGjsM+XclMmwozB/q9QtWpSqdcHPf/u8pSImq4bzBLZ14ICDNJwezglEFZcqbp0uFh
 p7qCX7ThR70yk5jPHYIg7Lu3OXrO+h8kw==
X-Received: by 2002:a05:600c:4ec9:b0:4a1:8961:78dd with SMTP id
 5b1f17b1804b1-4a18e4c9e46mr188478845e9.27.1791809419851; 
 Mon, 12 Oct 2026 05:50:19 -0700 (PDT)
Received: from [192.168.94.93] (37-48-16-135.nat.epc.tmcz.cz. [37.48.16.135])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abce2fsm19589082f8f.33.2026.10.12.05.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:50:19 -0700 (PDT)
Message-ID: <be619cc18f3072d5ccf7907b02b97e9236301c29.camel@gmail.com>
Subject: Re: [PATCH v9 00/12] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,  Amit Shah <amit@kernel.org>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang	 <wangyanan55@huawei.com>, Zhao
 Liu <zhao1.liu@intel.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>, Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,  Szymon Lukasz
 <noh4hss@gmail.com>
Date: Mon, 12 Oct 2026 14:50:11 +0200
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32e.google.com
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

The send process failed partway through, so patches 11 and 12 weren't
sent. Rather than trying to sort this out manually, I'll just send v10,
addressing the review comments.

Filip

