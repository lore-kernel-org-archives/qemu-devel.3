Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D797DC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 06:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl0iV-0000bJ-Vp; Fri, 15 Mar 2024 02:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rl0iT-0000Yq-M3
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rl0iR-0007sZ-L2
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710482808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JZOkvSxVP+jDlVHmbpH5W7wNbPSixXaqf4Ao0BtMhc=;
 b=JFCtHtzalz6TNAhkJ2pgzn2a7k0XmxTlI/mNd9hUaYf5XJHCnHHwk9WJKUXmNGC5nkHy4+
 UDfX4IxlY9GsoLkaaNLp+K7NVhMG5W0O7IqPnY/dzHAVNPYHLVW/6dmcPSCjf/72DVPlEG
 R4VOilab4NHWqhiaUqTj6v20hIhrASg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-VzJeTXLUMG-u8oqLiRQ54A-1; Fri, 15 Mar 2024 02:06:46 -0400
X-MC-Unique: VzJeTXLUMG-u8oqLiRQ54A-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5689a5ef341so1066127a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 23:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710482804; x=1711087604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JZOkvSxVP+jDlVHmbpH5W7wNbPSixXaqf4Ao0BtMhc=;
 b=g1eXYLTS6LTwxLzyuyGF5Q4CK7FOWFKmxmzS9RRlRF1JsFzdfU6Mhwuas95eNcOm+Q
 lvOFawsKYKmUcvzeCV4qsHlT4HSBjH+Hosd2Oe+0/lt614o2auR4sCi/dNmWxv/IQBK7
 Sh0carAPOIGp7Hwczhi5/beuU+d4gWUVnMp4edEg+ZuyIMf8f1P9KrFd6RYziQYmNoLV
 2buiN65Q6IBbxEuDR1iY+WUeW5ERK3E23qcpOSQUkYwROkK4E+5cWqAbTgNSUKj2unc8
 gLfm3P98TMPsb47Fbo7oIBYoFAD7Uincl0xVET7eOiTODHUk3jpPTw/XX7vIEFEu+H0Z
 ia2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe9AymMmp9p8A1kKcrrfbuz4oKx9ZYD0SlwC7vtNdyOe7eC9a5Lhx64aHEi2p44hvJMxteZh0VssMt1UME4L12ZBL0IzM=
X-Gm-Message-State: AOJu0Ywo0iztOPckGDiXWgrS8bMkJAlnq4kYffLyp7+ulmCnl3Y7FJSK
 6lM1BG44fzjY6Y8Xm/K3k1SLWSuS3xFFe+slZ308qqogJ5XzxhrgBTzsLMVjsuqJWgTuC831LwS
 BzwHZrhgrYCPJqfLb9w4XCbAm6XsPJjJ9YeI5x9By3zSLRzxdhvkUMMhQIps6lVjikNgURZhPmE
 gAk4kZ+VZ9yhdru4Kxim5jAFENMs54JWx+Y5k=
X-Received: by 2002:a05:6402:3605:b0:568:3004:c611 with SMTP id
 el5-20020a056402360500b005683004c611mr1430971edb.42.1710482804469; 
 Thu, 14 Mar 2024 23:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrMtAJHaEIZ+eI+cdisoFQGkdCFBaZXTzwfISmJJlZQY4X71cqJGkslOBuXBBVnbPdI/ZiILlA7zB2wa+tYoE=
X-Received: by 2002:a05:6402:3605:b0:568:3004:c611 with SMTP id
 el5-20020a056402360500b005683004c611mr1430959edb.42.1710482804191; Thu, 14
 Mar 2024 23:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240307062823.2377318-1-justinien.bouron@gmail.com>
 <20240315023620.950554-1-justinien.bouron@gmail.com>
In-Reply-To: <20240315023620.950554-1-justinien.bouron@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Mar 2024 10:06:28 +0400
Message-ID: <CAMxuvazGzq+EZjS3fOomp=wnZy4RwU9msUdjxXXuT3spPADpGA@mail.gmail.com>
Subject: Re: [PATCH] input-linux: Add option to not grab a device upon guest
 startup
To: Justinien Bouron <justinien.bouron@gmail.com>
Cc: armbru@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 eduardo@habkost.net, kraxel@redhat.com, pbonzini@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Justinien

On Fri, Mar 15, 2024 at 6:37=E2=80=AFAM Justinien Bouron
<justinien.bouron@gmail.com> wrote:
>
> Just a ping to make sure this patch hasn't been lost in the noise.
> Any chance to get this merged? Should I send a v2 with a revised commit m=
essage?
>

It's too late for 9.0. Please send a v2 with updated commit message.

thanks


