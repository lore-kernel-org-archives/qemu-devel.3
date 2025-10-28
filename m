Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8BBCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoeL-0005pr-R9; Tue, 28 Oct 2025 14:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDoe2-0005OK-MK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDodW-0005rM-EI
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761676895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JE18ZjWlXAwit2z6n1ZQ+ilWG96/G0LXLXd9ZdiuWQ=;
 b=Zy2aU01uEkYNwrunKI5fgMq8XTP/wG29sNZvXYgtu3QEXVPwXu/WYRikZcsDvqgss35XyH
 /Q6N/Q04Ck56BUsqc09b+HWaxRYAQLIVoiJ8zVl6/NdxynW82MJWahWqz2zDVwURoCh72j
 ajasflh++RkNqRWI91beq4X26LFOi+M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-kgceK-MoNH6sRilln-r2mw-1; Tue, 28 Oct 2025 14:41:30 -0400
X-MC-Unique: kgceK-MoNH6sRilln-r2mw-1
X-Mimecast-MFC-AGG-ID: kgceK-MoNH6sRilln-r2mw_1761676890
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a15d36c209so985660385a.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676890; x=1762281690;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JE18ZjWlXAwit2z6n1ZQ+ilWG96/G0LXLXd9ZdiuWQ=;
 b=ftBCyLjkPNOT3TEphsuysxQaYq5kysggQXd9ziY9MpMJxAa/Hme02XmgYN2iWR2Z9g
 mt4vLctcE4PEVgNE3lHytNv3itzIV8YOqMt+lbkoZ2PnIovMU8iBbRkB4n5lg5Pko4D0
 xdLtpg4XjCqPDgjOUpGIUggrMyeQJYVK8Z9edIqUXxylIpPmANDkjgn+Gt/uZntozKUS
 0k4JKbazRh9H9GMTmrcDY9wb9nlW4dr9+u6pbjfba7z7o7qfblTr48pwJT9M09n+9p4n
 gmtJZM0jiaTtp9OrFcZZWZ7pSPZ537D/IhxTc4OhDaPqE28h266xtjdHVTblGfKYX0vP
 GNGA==
X-Gm-Message-State: AOJu0Yzhgy+5r9heAzo8eNgEDQWwNI+fw+5N/mPx7WsOrOj3dYoz1QLU
 wweMfHhSuqIJeIVwFux1eEFohqFx7k43Rkzl93sCP2dKp1ccSDi7OHRK3OEv4FE5Y7Q/x75o7Rf
 IxX1frfiP0y7akGL5KxmyejdGtke0Dy0ffddQpyXTXXlSfk9apHzisPtuZQVqNS8n
X-Gm-Gg: ASbGncv26aLM0sKn1x3fdqtiQu5VXdZlVUE2h3urnesNc/qilzoYtOx6hoFxvICeRqI
 6+gP4ZxATRHWtbadlCaIqrOSMLREsFEfyzg9G5PdZN9Pm1TIZtNjivgmP9Kch106DOIShd3mwCP
 XpAqRXISUTtVkmtI9iUdpCLSHZ5FRncleFKfzTW2oBREY4xav+l27Oe9uAQawv87niAzusN3UxW
 cPgBle+bMTsp1/W1oKDizVGzDIauMjp/1vZTb8BFz7MNtquTlzdwbiJAVNnegl3Sl8hoXZEml23
 0Pom3Jm5jYWRkEBtffQhVSmMkxpWZwR3ysHaPLhp9Ws3Gn4kGyGUANCZMSL64oq6Vzw=
X-Received: by 2002:a05:6214:27c9:b0:798:acd7:2bb with SMTP id
 6a1803df08f44-88009c0b912mr1037226d6.51.1761676889834; 
 Tue, 28 Oct 2025 11:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz9dR8kMz0S6e9uZHFhtek7D0C9LNsYC8wL8XSrLNCkrY/ca31qp0JCfvcV3KUiInSS0KnQg==
X-Received: by 2002:a05:6214:27c9:b0:798:acd7:2bb with SMTP id
 6a1803df08f44-88009c0b912mr1036896d6.51.1761676889279; 
 Tue, 28 Oct 2025 11:41:29 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc49204dfsm82115346d6.30.2025.10.28.11.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 11:41:28 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:41:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 12/25] migration/ram: Use memory_region_get_address()
Message-ID: <aQEOV2ucE_77LJD7@x1.local>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-13-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028181300.41475-13-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 28, 2025 at 07:12:46PM +0100, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


