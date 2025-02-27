Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1248FC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYFB-0001QE-Qa; Thu, 27 Feb 2025 02:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tnYF8-0001Ps-D5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:23:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tnYF5-0003HG-Vl
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:23:38 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22359001f1aso3438895ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 23:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740641014; x=1741245814;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4RJMBXhpWQnuZsfaTPxuxwETqQJN6LdKH47zkrmh+F8=;
 b=jOKV+etu7myp/RfEKog1sJwfeGhJjbcEV4dQiZZR3zkUtzQ0GGAiED5tle+d1XTi6v
 /fFEXyLnfbbwPY9LXv2P8xnw4YPaOmXTH2L3BgRIrxn+M+h6HQJXoQ5yNvSplKOLM2bJ
 v4l70rEszN3v/yIZ6fY+ZtosNgJXagV+rgy+oSjf9qFcfIf3CuHKVCRhry7ANN199S4j
 koWPbwBBSncr04jnxJizshzgI7qb1yLdA4mZSIF48ltA4FfCx7KpgZCrYaGQb9nwL6aT
 OQKujC5+beM4jyIuXQguTIJOjQUz7a7neyp0HLIXywsigh9J5wPirDC9z+giteWqQ9g+
 3n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740641014; x=1741245814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4RJMBXhpWQnuZsfaTPxuxwETqQJN6LdKH47zkrmh+F8=;
 b=t8JUf6B+IHdIzgqmye1bUbaGzg4BIsNs9B/xzlHCNsOXIIhEIvrAw2jrzGwejMJx7Y
 gqiB1qSD5G+QJUCnZJHF/2bqoC9BRWeTjRd2ODHgxiRDP5ti4+yfbEfDhIWnA8skI+d4
 6IvgoSYVqeVodibODmGoLX++y3JRK67nJllYweMExxvELgnx2soLgGI6mfi1Jfl4pWUp
 /b8wVI8CSesKvDJdGTYXJmBHv1bmWEU6PLwZ9iRU3NyPDMgVD/Rjo7frf7eOw48zM52Z
 p2vTgYSXEhOJDUVJqcdmcTdffSKntxDzoTgpOaNzI3B2jVJqZyxPms7Gl88R4InUifqK
 tNMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDPIW4pZgJB8fgoLdZaiDnJf98lPNviXr2210mVB7NVsOYN9UTBjS+poc068f8ZDfEhRVF423fenSE@nongnu.org
X-Gm-Message-State: AOJu0YwXp4e68THPnCOK6BNTIbxLN1ciyH7LL5POZF+IwrqH9x2/i965
 DbUfvm1u/zbyX2Tp/InnVEzZN/STCOuagarRXOf8kxmVTlkiNzYDO069j30VyVI=
X-Gm-Gg: ASbGncsZf5hSY43o2WJBmf4l3itUdbPLELZ+Lpuo+wVJW/hK8aIPAGsTlW80Gwo5xFX
 cu1i9s9cqKsyzdmz2/c4RH26sRGr175d/nXlTIUxqWPSFzwmgcwfI6a1tVlQUPvo7w9FE6SgUff
 B1oVtFsKbgHzFvk/I3XaUo+N1rs94lzn6YwiTnaCA2+Dt7r1cMVueTXCBmD00Rx4EaohYHJhjW6
 C2mDTgm3VBN7sCgG2iQSMIj1Pur11g0OI8pXwcCtuGsFfr6RGXlSB2r74mPaorjtzy7XjEo6e1D
 55Pm+mo1/ECUyx5ynh9pp1VaSVLDxmO6RjQJvDc=
X-Google-Smtp-Source: AGHT+IHJgmc+6TdnvzYOSCew847mr1bwE+3quk/Hj6fZt8Jqp210xpXpPaZqu0yIG4bV8082V294iA==
X-Received: by 2002:a05:6a20:8420:b0:1ee:d515:c6ed with SMTP id
 adf61e73a8af0-1eef52c98c3mr44931834637.3.1740641014326; 
 Wed, 26 Feb 2025 23:23:34 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7dec3dd8sm696922a12.60.2025.02.26.23.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 23:23:33 -0800 (PST)
Message-ID: <85c8eed4-ed0a-42d8-aa55-52e44b827a8a@daynix.com>
Date: Thu, 27 Feb 2025 16:23:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] pci: Use PCI PM capability initializer
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, clg@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
References: <20250225215237.3314011-1-alex.williamson@redhat.com>
 <20250225215237.3314011-3-alex.williamson@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250225215237.3314011-3-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/02/26 6:52, Alex Williamson wrote:
> Switch callers directly initializing the PCI PM capability with
> pci_add_capability() to use pci_pm_init().
> 
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Klaus Jensen <its@irrelevant.dk>
> Cc: Jesper Devantier <foss@defmacro.it>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

