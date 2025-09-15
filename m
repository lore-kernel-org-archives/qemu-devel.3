Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1901CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 23:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyID5-0006gt-Qi; Mon, 15 Sep 2025 19:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyID3-0006gL-Pq
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 19:02:09 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyID1-0002jt-KK
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 19:02:09 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b07883a5feeso823926666b.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757977324; x=1758582124; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xEkZik1YGk47OpDU1f55FZimd5u4mFr3OyKc3J65ewM=;
 b=C4ZDsMvLiJ4vrNDH9hjbX5Nd3llybDg6RNYNbjYAZkEo84DISPT/C7pIcMSh8eiBpt
 j9cKK34n3jepz8xTWGu4syDOhcqSeTPWtI/w6BMbkhlaVadWigQ0E86deGquIkrKWHHz
 78euUtu2saZXiq3ykjvLB4wBF8G5HuqpBAoL0bvZhixCpg83eYrzoajw5G/Na/LyJyoc
 bhArPKxAFBwidPrD8Tda0EZ6TiOUxZ5BCTBD+1uLz0M8SpscIpQnIg7KZpyajAQT/0Ks
 wS0r5UfZVs3NpDHcXnwe8lHr6FWxv4tbVBXzuqcbv3DVFbTPG8MyaKQTRvID9RWQ3+1U
 0VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757977324; x=1758582124;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xEkZik1YGk47OpDU1f55FZimd5u4mFr3OyKc3J65ewM=;
 b=briiM5j2cf5zIJHLE6Mh4r1PLZOK3tORVlpfUhi9x0FdimcrRBoLui2KB0hH1OmnHv
 mbOkonGhibuBjh7USoFpgZmzyqfOmesfn0CMlU3Q9AWKsuDhXylbKrTkgHmIJE3woCdJ
 FcoUffBRQbWd8gfP4CMgJlq3zdv6yt4CqkOjFbsrEd9xk3V5a2DzlHyQ5JIDpja78q3T
 m3eO5YrVpb28ReQ/xQ5fd1vKF4SnaST8bRNVWsWYsw5VIX1gE1A1A8OKsi85N5Ucusiz
 Wv6NnAKNBrdO1jIbZqpXUPshQ2lBne0zyrivHknl00F9JUMnP5vrU+V6NR9BfZ75bZJG
 ItJA==
X-Gm-Message-State: AOJu0YwSE/wvhc6elij2F5ffI9UsjEEKHjM2vUe4/9Vcatn7thUO7Cw3
 trCMKc2+P8uQv6sA6pAEy3K+vFGSaCddvjSYkEnfZgBuNYrf+2W/auWNJpeObzaZ
X-Gm-Gg: ASbGnctMRp+Rub31zEaFpDmLXZHqNoeyfUpzywb4myTGaD22VwjSCJo4jxGzpbiHBxY
 9ajw8IV3+5e7+n6+CaoWdYadICAXKAeLXxZ3WJlrt3nT4QQP6BSXfToJiHyNekADiTISw2m86SZ
 FIa0BefBqGUQ/UNdTNFq9jEUcftbzNgPmZSmUphPOr7pV+42lWGb5fhOxVYoGv84xvnYwx2ew1o
 DXzl99eiGVfi43qDyDFFvaswUUDl7YMcpcbk9C+4D7/O1CU4QNZpaLuFJHjLvI55f1kfRjxfSnm
 M1itFX4uyl5l72ekNC34AP2JkzHLu3OURPdIFmc27lppG1wJS3kI6Mujt2wf8xbQqEDtDYg76Z5
 VjoHd4iy0b4Bjk01wVEwEPqUm7OMkri8BcRf415qFggt+DUE/GHfCTl0vWZ4Y
X-Google-Smtp-Source: AGHT+IHFBDjatHuEWlSqWk3dsMkijnNM1NZnfhgj9q4YdPUvxNdEYRXmhqvrJc1yqV8nSHuNSGe5AQ==
X-Received: by 2002:a17:907:3d16:b0:b07:b7c2:d7fc with SMTP id
 a640c23a62f3a-b07c354074dmr1185225566b.6.1757977324370; 
 Mon, 15 Sep 2025 16:02:04 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0906a9640esm579660766b.110.2025.09.15.16.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 16:02:03 -0700 (PDT)
Message-ID: <ecb9a5310ec1b846124a6342232dd421778df064.camel@gmail.com>
Subject: Re: [PATCH v4 00/10] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,  Amit Shah <amit@kernel.org>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Szymon Lukasz <noh4hss@gmail.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>
Date: Tue, 16 Sep 2025 01:02:02 +0200
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x62b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

While thinking about the patches, a few questions about the virtio spec
have popped into my head.

1. Should the config space size also be updated (for port 0) when
multiport is used? Based on my reading of the spec, I think yes.

2. Can VIRTIO_CONSOLE_RESIZE be sent if VIRTIO_CONSOLE_F_SIZE is not
negotiated? The spec does not say, which I think means it can.

3. The spec says that reading from config space fields that are
conditional on features should be allowed even if the driver has not
(yet) accepted the feature. Does it mean that we have to update the
size even if the feature is not accepted (yet), or is it OK if the
reads return 0?

Thanks for any answers or opinions,
Filip Hejsek

