Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601C4D637A3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBI6k-0006nL-Dw; Wed, 13 Nov 2024 13:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBI6j-0006mW-JZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:28:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBI6i-00032q-1d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731522526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPPhjIYoYUJwFyH9rQf8tfM3zr542lL+oDU9bi0lYCk=;
 b=fzBHEX9g8x9qp/pJOuXb7hvYtLWeQJiFtqc/xnHQZ+2258Iv72UoreHRDJoqBuzBwMAyll
 TKRPNu8eIO8PujFbQQ/A0/7v2RfYivJwlEMap03oLChbKD3OoTWz/JdORhPLUyrkDL4lM5
 o1u+BjN5lp0esqSKaLbwU829Y0mk89s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-SeFfvlkcOvq8Nulj6hap4g-1; Wed, 13 Nov 2024 13:28:44 -0500
X-MC-Unique: SeFfvlkcOvq8Nulj6hap4g-1
X-Mimecast-MFC-AGG-ID: SeFfvlkcOvq8Nulj6hap4g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d45f1e935so3921620f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731522523; x=1732127323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPPhjIYoYUJwFyH9rQf8tfM3zr542lL+oDU9bi0lYCk=;
 b=IJndxcD2jwHieNhMtgp+J0uzv9T52TtiJ//eBD6xi0rwTC+XGygD2PZ+Pmn/+UxOXT
 9SfRva8sG026Yk3Y2tVVCQdyxjngWBpgtWA7504uJDINuVN6BXVmChi7xmnAjp4vmQFy
 ASltRVUhZXE5AcDmipI00ECK0j5E2xbEG6Zuw4DYpERmatpt+oqtmBzTZLSmntAlJQaq
 mmzyu/NIWABEzIAjHXmk+P3NpLVYu3hOfj3igcvgQJFN7EKgqJpK9rnOrRA4k1f7PKfq
 AQep0IEdU9Cm0U7JFXMyk0cr2EuJluLCW/Y22FtpS++2M/h3zijvo8T/jaRQab9AmBnQ
 T7JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBt43oX/2hIAMVdBlTiAgdYLUk7xGWzSnSCJux1FquxpbTbIGZ7dDaT7+D/65cuOL7v6SJRBa9L04g@nongnu.org
X-Gm-Message-State: AOJu0YzD8GQxqlfcvC70PjUTDOvebgf8p1gRnZBSa75ShPr/7KPbQMNU
 MlHZ1SEGx75A42ssBMY9Z7LqjmCZc+Kdsu/KQZc7ywh7+gJtWk3ImF1I3xvZ0xVYlkkcVxrzt3o
 XnPJ9Hw1/gU3UynuTD6MOML+aBqHocu6G/x/Ojse73HeNzkR98H4xgY3yXhf/3S822+OYRp2xIk
 OryqnLEiTr8MZYerKB7UBwxRzfjGI=
X-Received: by 2002:a05:6000:1f82:b0:37c:babe:2c49 with SMTP id
 ffacd0b85a97d-381f1866fddmr18472898f8f.19.1731522523487; 
 Wed, 13 Nov 2024 10:28:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMHJ8qJPXx+mdnK2vb7FoN8fS4Hx8RsD8Id7NslOegrqiOjM8377BhGCxuDeDDtMdZD756vw17YqNEdv+djzE=
X-Received: by 2002:a05:6000:1f82:b0:37c:babe:2c49 with SMTP id
 ffacd0b85a97d-381f1866fddmr18472880f8f.19.1731522523174; Wed, 13 Nov 2024
 10:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20241113163800.355547-1-alxndr@bu.edu>
In-Reply-To: <20241113163800.355547-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Nov 2024 19:28:31 +0100
Message-ID: <CABgObfZsesHr7gr8CVgW471hBkW6E5rfhpgtBTuM5owuPazPNw@mail.gmail.com>
Subject: Re: [PATCH] fuzz: disable tcg for OSS-Fuzz builds
To: Alexander Bulekov <alxndr@bu.edu>
Cc: Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 5:38=E2=80=AFPM Alexander Bulekov <alxndr@bu.edu> w=
rote:
>
> OSS-Fuzz builds have been failing due to some strange issues that seem
> to be related to color codes from libffi:
> https://oss-fuzz-build-logs.storage.googleapis.com/log-8d5435ee-1677-40af=
-9656-b4162fa881e1.txt

Hmm... unqueuing this :)

In this log, the error happens even before QEMU starts to build. It's
glib that is being built here, and it's failing because apparently the
compiler does not support -fcolor-diagnostics.

I can't exclude that the same error would happen with QEMU, but this
patch won't help this particular log.

Where is the Dockerfile that's being used?

Paolo


