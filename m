Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A130BC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpPr-0000y0-FC; Mon, 07 Jul 2025 13:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uYpK1-0002pg-VE
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uYpK0-000388-Bb
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751908083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MyDV3lIxztqqukeWK5Q8Jx98oybe1AsNhZ1m0EpbJa8=;
 b=ReLEjFkHQRQHDoX0LhjvI6nE0UT9KHMVexLhOK4ZdmiLp+l2+aKKe2RbJ6nkYyZn7E4z8j
 RhVBj8dgqSnXtucSgwzMKFsyt2Mb8UmGzvJdcI5qfSlKu0PMvsbztV5c48TfrSst+rV1XC
 sz0tCb8+Hr5m2sMUVE0VxRFDfuU9zVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-OlIMlAjMNc2TbY9_qB1s7Q-1; Mon, 07 Jul 2025 13:08:01 -0400
X-MC-Unique: OlIMlAjMNc2TbY9_qB1s7Q-1
X-Mimecast-MFC-AGG-ID: OlIMlAjMNc2TbY9_qB1s7Q_1751908080
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4530ec2c87cso25813795e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908080; x=1752512880;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MyDV3lIxztqqukeWK5Q8Jx98oybe1AsNhZ1m0EpbJa8=;
 b=ScvF01em86SS32m10igMXsw9X95ALtMpbIH3fRL1bxeYaOtF7sW1fyYQssHcdU1bRJ
 YqLPkqp0EgbqOKeYh+cta4X+Zf7t7ynPohyPRMgxlfB1XxlllArN7QJKF1po8RFHn08f
 GzZlU2qIU0mCkX1GFroDEzDmiiCFnrcuvJJSKDj6hkJ1CjUxh0hNrUOu23v4ecwl7+/0
 /VpiGBd1oS4t0zSDxzEw7EnQlbJOPYIA9f4rb6ffdUAl1gK1dMkWDFZ5CRgr1/UR1IaY
 HvwoItzBrcxP+4UnTOgNWWOwMAGch5FG4/LbFF+Q/zOrwfd7VSoVOnWcEU/duc9P509V
 b7Qg==
X-Gm-Message-State: AOJu0YyYtfWH5xvAB+kYgnvMuQM3aGW68MPZI2ndpz/wWdcM2A+mbBQS
 YQ+sI9U7FADv+YCdV4cpIl4GDEbk3wa8RZx88Nrsw4iqbdfm5Fl7Mh/wdh9seIzfiSxqOL4YGYe
 +6iP6aWRpwz3XjCzZFpjbCTRE1llyOGEPMbQTuGYaoC6Z/N9v7NdiECuo
X-Gm-Gg: ASbGncuP4PL4R+KTFtkINEyt1xhjJ9uIZlvvR/h2aHKKHHvufxpdALkSmRmFyd+/jOk
 RCAfw/oDoSwKW597WzOfWK4N2B6oBUoQ+6wwb75Y4xSynY8IoDOgmftO95EmyLhGjspZvGSoW09
 tQI04SYXHh699UyVm1ThTFG1AtrVAi16ZOQIPDuuVuXT5GNejKru1OzSHtVBD0czu7YGEI45cbF
 /FSB0DaB124COwpSgH8KVSd8h+Lj8hKBTyUERBWqxhqZMhTHf89MyGlGbWRtNHv2gAox/jhocmz
 4Hplu7GG8KsLxPtRjWAQF73DK7vv/kIzqn3Rr15NIiGfL0d6vbUdYDfF+Zeq4Nw=
X-Received: by 2002:a05:600c:4e46:b0:44a:b478:1387 with SMTP id
 5b1f17b1804b1-454b30d9516mr149610555e9.17.1751908080317; 
 Mon, 07 Jul 2025 10:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSrx2WBWZYMIld57aweLjb1ssqt6cGui405gRSL6FNi9Ld2SLoEl2Caq78JPnYjpmrg1VG4Q==
X-Received: by 2002:a05:600c:4e46:b0:44a:b478:1387 with SMTP id
 5b1f17b1804b1-454b30d9516mr149610165e9.17.1751908079914; 
 Mon, 07 Jul 2025 10:07:59 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-131.pools.arcor-ip.net.
 [47.64.114.131]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b97353sm10956994f8f.51.2025.07.07.10.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 10:07:59 -0700 (PDT)
Message-ID: <407bcd9b-6f80-4d5c-aa28-5b95cbfd61bd@redhat.com>
Date: Mon, 7 Jul 2025 19:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bamboo ppc Linux image URL is 404
To: Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <CAJSP0QX+WARJQ_6oN=vPyzkotQ01W0Jk5S65Z=Npw0BYp3jdpQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QX+WARJQ_6oN=vPyzkotQ01W0Jk5S65Z=Npw0BYp3jdpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/07/2025 16.13, Stefan Hajnoczi wrote:
> Hi Thomas,
> The following URL is 404 and is causing the functional-system-fedora
> CI job to fail:
> 
> qemu_test.asset.AssetError:
> http://landley.net/aboriginal/downloads/binaries/system-image-powerpc-440fp.tar.gz:
> Unable to download: HTTP error 404
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/10592622177#L1047
> 
> Please take action to make the job pass again. Thanks!

With a quick search in the web, I did not spot any other location of this 
asset. Looking at the MAINTAINERS file, the Bamboo machine is also Orphan, 
so maybe it's finally time to deprecate and remove it if the last known 
working image has vanished from the internet?

  Thomas


