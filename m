Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966B1C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 10:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ5oY-0006C0-QH; Sat, 18 Jan 2025 05:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1tZ5oV-0006BO-2p
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 05:12:23 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1tZ5oT-0000AB-J2
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 05:12:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso46517745ad.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 02:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737195140; x=1737799940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F5zwCBqQloyMpycJYlg1aT9PslF0mMz0TkFwRM5GNVs=;
 b=mvWz58K5/hrU5TyQsKzK1WfBKsTsWfVFPbcB4zFIF1q9y9E0n4kp5tPR3KzVKsRACk
 GUW8Y9KG5nGBeD7cnIX/J/Ly5j5n5LCTN131Uv13QnKO/vmOCfqiqYfwbtGOEl6Kf8Vg
 a8zFxqNtC82xy9UukS6l6l8mvPYpqoHATA0H1HuwdcmXvSXw04aB/Y0zvMXBp2kyqMau
 ydpS08ffWvdqrJz59ZPV3mLkhqpb76IFyNLrAr+yLpprVSBQgOIIW+R+IeQD3iLp1btm
 wpoZJlRzmsHQJlOtHbtPtDKJMWtBH/DrDyGtuCNcXp9Q45XHd53xHZq98a3r80Bo0Huk
 opcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737195140; x=1737799940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F5zwCBqQloyMpycJYlg1aT9PslF0mMz0TkFwRM5GNVs=;
 b=SDTk5QosKfhRuT5OIkrFsnSTqTu1+greAbqVA82ucrEgaB9dfzD64qCXU51Tbdhb49
 tpiUnhvWpumrkPdeq3RGJA2WIRkMyD+uHgW5VwkdSDq96qz/nJfovWSQRX2KpII1yMmi
 mLCzImrszn4aSDhQmiEFufxVS8LHgMselb1S8i6WQ6lZ46KHm5U4tAcAjkFe5SC3JzPO
 sagPJRcOczLrrvxnHE1BwK7NB8I5vq/oXgZr1qJCDn5+zE0z3JWuYa3u8efsO9Pqc8Gk
 X1D3ViX1HJmO4NLXOUuK9hTyQcELV36DXgSveqs87or6OWUYLWiwP4qzCkru1FtXKbRE
 C7Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7fn9ezHpIRz2C+k4FhIey3uqKKz87NsN5m8AhvgjFv/cdCaQ56TzWz0gnt2JJ4IyeGJF2pIU4agEQ@nongnu.org
X-Gm-Message-State: AOJu0YxZs6McKP90odYZ/dC39Nbo1bbEsMCS9uh2rn7iGi8cSuzdPnaj
 f73+SQGZVwgBV++t+vHn0XXvsOdrULUCTSAwbezDaQo4Da+PB18v8qAta9Hp
X-Gm-Gg: ASbGncv3Dntdkyq3SmwEqlEIAmEKUoBeu4uXuWgoFClPFx2M0ReYKWw31X/FusJ02tN
 nb/qLrB2Q5t+GsfX4Wh5iqK0bLqnFVWWQXcuqZou+qAN75hLWyBmywa7zjxSjJeRtfVv18OHQmR
 Bd7J1O+96x3Y0VTxUx8qUdX4wE1QOdESn20VpRcRhWP0rv43yE/qrf1OLV3KRC2M0y1/d9B9ncx
 W7n5TplllaOta2SwLehLhn94H866tHsCrJfzfYBTz+h90cAqetqWp5LYsMJiIms6uuYM3yKWL1T
 iw==
X-Google-Smtp-Source: AGHT+IHohMPhMq927DUiadhGBU2WFVSDZNtrYEajT/CRqDPFPQAtqy7T3+ZTnL0fHGrYCv4RH2Zasg==
X-Received: by 2002:a17:902:ce8d:b0:21a:8ce5:10dc with SMTP id
 d9443c01a7336-21c355835e0mr91239995ad.28.1737195139891; 
 Sat, 18 Jan 2025 02:12:19 -0800 (PST)
Received: from [10.4.77.176] ([118.103.63.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4027e3sm28792505ad.222.2025.01.18.02.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 02:12:19 -0800 (PST)
Message-ID: <cea3fcb3-cec6-496f-ad59-3bd0b5ed9ef0@gmail.com>
Date: Sat, 18 Jan 2025 19:12:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/dump: Correctly compute Ethernet packet offset
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <20250117111709.970789-1-lvivier@redhat.com>
 <20250117111709.970789-3-lvivier@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20250117111709.970789-3-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x629.google.com
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

On 2025/01/17 20:17, Laurent Vivier wrote:
> When a packet is sent with QEMU_NET_PACKET_FLAG_RAW by QEMU it
> never includes virtio-net header even if qemu_get_vnet_hdr_len()
> is not 0, and filter-dump is not managing this case.
> 
> The only user of QEMU_NET_PACKET_FLAG_RAW is announce_self,
> we can show the problem using it and tcpddump:
> 
> - QEMU parameters:
> 
>    .. -monitor stdio \
>       -netdev bridge,id=netdev0,br=virbr0 \
>       -device virtio-net,mac=9a:2b:2c:2d:2e:2f,netdev=netdev0 \
>       -object filter-dump,netdev=netdev0,file=log.pcap,id=pcap0
> 
> - HMP command:
> 
>    (qemu) announce_self
> 
> - TCP dump:
> 
>    $ tcpdump -nxr log.pcap
> 
>    without the fix:
> 
>      08:00:06:04:00:03 > 2e:2f:80:35:00:01, ethertype Unknown (0x9a2b), length 50:
>           0x0000:  2c2d 2e2f 0000 0000 9a2b 2c2d 2e2f 0000
>           0x0010:  0000 0000 0000 0000 0000 0000 0000 0000
>           0x0020:  0000 0000
> 
>    with the fix:
> 
>      ARP, Reverse Request who-is 9a:2b:2c:2d:2e:2f tell 9a:2b:2c:2d:2e:2f, length 46
>           0x0000:  0001 0800 0604 0003 9a2b 2c2d 2e2f 0000
>           0x0010:  0000 9a2b 2c2d 2e2f 0000 0000 0000 0000
>           0x0020:  0000 0000 0000 0000 0000 0000 0000
> 
> Fixes: 481c52320a26 ("net: Strip virtio-net header when dumping")
> Cc: akihiko.odaki@daynix.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

