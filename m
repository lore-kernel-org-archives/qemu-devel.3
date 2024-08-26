Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA7C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 07:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siTvq-0003ei-OR; Mon, 26 Aug 2024 03:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1siTvo-0003UD-Co
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 03:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1siTvm-0004ug-NO
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 03:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724656464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nqKtN73SsVBHh7kwtTbGaclxlu2vd3kW/lJhF5p9x7U=;
 b=L5j+HAAorDksXeNn7A24HT5S5Dh9edVgPNl8U2sWLCqC4LIPOFTGzw8Ffu4tTz+AB8MgPf
 AwPGzzHR6dS8+hyxveSLFFRvQHHVmQ+bMzrIlmEvYrC+pcUh8wYWtiAv0y2/sR487baAKe
 SuFPNobJoPPu01k4UfjDtheGF/Gnhws=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-JXdrV75wMe6juUoa07sYhQ-1; Mon, 26 Aug 2024 03:14:22 -0400
X-MC-Unique: JXdrV75wMe6juUoa07sYhQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42808efc688so36448765e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 00:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724656461; x=1725261261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nqKtN73SsVBHh7kwtTbGaclxlu2vd3kW/lJhF5p9x7U=;
 b=LNmFeNthnx3QL4wUfUtCnMrqxIqG/SZ0ZJFBYfwauaxPRdbNbrHOy6OToNAxjTATcj
 4HNglt5T8DUlVVHN3M8tqeqNLjrBWzDMBzwrQw67qaMv75CtD0SBUdX8rH2x3xUFKMxh
 F5u0rh78wnL/vFmyUsomT4n8MB4azqW6A/lP5d1FSp2Kyywf/gfcJE09L9OBvGI/FTe3
 9Zq1dd0vMkGvLR5ighwDvFrlPeG3oI8aeqToKR4eRILm7UKQN8Sa0OYRCdeB5IhFf2Om
 65g+wX9co4P6hophZchfiHyL+SAAaOWH5sjh4R2GDQD/Tb3ZYjMWSfHtDCKD0el9th6t
 BR8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg8WoySjOm3Lh5HpEpFmL1//MOTG0+sS9OT57oqyx0FJM0cRWcpfPlL6oJrmxvxNWgDYYX8RtnaUCy@nongnu.org
X-Gm-Message-State: AOJu0YxoClNgTIPbHzxqRWdTfoYe47DSzVXaKVpNIOJwEQPObJKVGKSY
 QVwWtrJkGBsCvNVNFc4xijZs+8w+YrEDJ/YT5vgtqIyl4wOKQwRbb6zyVxoLkEnjS+YtgrQ/Ovi
 OBsKVaIk9lROGMpcZcFp+WiPYgqn8OVfsRcTz4TLmMzBgNec1ESTDff/RKz4Om2nnOet13hBLce
 etyY1GsTSJlX+dfv7++TlzRXI574A=
X-Received: by 2002:a05:600c:35c6:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-42acc8d494fmr64777615e9.4.1724656460792; 
 Mon, 26 Aug 2024 00:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETGlfbeo83Kbyr9+xMsGSurSdeFU0/mvPqfbYymt9QgUp0os9UyF1GnDXlTAZL+aAFoSXOqsklLnmFTrS2+7E=
X-Received: by 2002:a05:600c:35c6:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-42acc8d494fmr64777365e9.4.1724656460332; Mon, 26 Aug 2024
 00:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
 <20240820170907.6788-5-yichen.wang@bytedance.com>
 <CAE8KmOzK=Qe3nJ_ReRmQr5hkUgoZe9nOBi5G0hByvG3oVuzG+g@mail.gmail.com>
 <CAHObMVZFb+7d8W90TEEzwf=X_RJb238RQG0CEcD_UqboYdhVnA@mail.gmail.com>
In-Reply-To: <CAHObMVZFb+7d8W90TEEzwf=X_RJb238RQG0CEcD_UqboYdhVnA@mail.gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 26 Aug 2024 12:44:03 +0530
Message-ID: <CAE8KmOytSMPh2M9Vm+Z3v80u6MB=Vm0PDjjAzLZAvwJeJP644Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 4/5] migration: Introduce 'qatzip'
 compression method
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, 
 Xiaoning Ding <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 24 Aug 2024 at 04:22, Yichen Wang <yichen.wang@bytedance.com> wrote:
> The patch was originally written exactly like what you suggest,
> cleanup in the error path of the same function. However, later I
> realized in gdb that I was wrong. The qatzip_send_cleanup() function
> will be called later in another thread in both normal and error paths.
> So I revised the patch to this behavior, otherwise I will run into
> double free in the error path.
>

* I see, okay, in that case:
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


