Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1622C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 10:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uisI7-0005GZ-7f; Mon, 04 Aug 2025 06:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uisHx-00059o-2t
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uisHu-0007N2-9O
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754302760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1roduKq8d3fR89Fan6OUkTDIqiCuLcLEdeoD0kzWYWA=;
 b=BiXb3uiCGY7CZ8n9tclUXEEqcNh8MJryvQDIWGpmX+KtlpUSbrfSKjlw491v+B//ryr/Vl
 fFviLHNAM58y1HhegnsGvXt/dD4xStdWc7PSZWQrYTvHgJSs0GeFi3BtZZ5oifac5FX5h8
 bPYSf0twbgJkU2/pCfWo9MtfHCk5qs0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-taGsmsd4N2GkOsoQ_OU4zA-1; Mon, 04 Aug 2025 06:19:17 -0400
X-MC-Unique: taGsmsd4N2GkOsoQ_OU4zA-1
X-Mimecast-MFC-AGG-ID: taGsmsd4N2GkOsoQ_OU4zA_1754302756
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b79629bd88so1679687f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 03:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754302756; x=1754907556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1roduKq8d3fR89Fan6OUkTDIqiCuLcLEdeoD0kzWYWA=;
 b=pfcbdxIWcEbf7UHt3e5d1a4ncMFrFLz4+gORF9bMruFqPZ++GzlScznI4RVzbK3asI
 9vlaJcdoxscYX2lgou60f7XRZtk/FsTYIMOv8JclreisGuVGW1scvCYSIix4GTX7xuRe
 kE0zJqOsbb2XSINveiBeVuka1RmfVHyOKQ7jIxlFFJKcR2NhrUDg8SHx+LUH8GKKO+Js
 EOV1Tjqrz2b1Be2eFrOXAELsyufeJ7FqAZietbNmLrNHcX2YHXJgXn+10vnrliYs0EAr
 e5q2BhG9wYK8ADL2Kp8tYwI7i73RCNmryhnJ0jtZOCffGOuILyjRF0FSbJ+8UhfXz6lC
 SePw==
X-Gm-Message-State: AOJu0YxEocnfnsDGt7dGoc0zaPOrgaRCVmA2YEEaGZ77/+zwlkpY7qPy
 43kxmtPjBv/3XJVCY3fyxU19alvNEGJSq8O528P5lr49uA23trasViX2cfo0cvdp9Ll+fieABXe
 vUT8aYHYiGImoVwRq2j7KJ1v1+ji1qwoC8vs2uBRuiJTZirkn019Rmt3ry2b0uDEWb3neP6alIw
 8LrYhYzVR+GIzILXceZGDaLSV+p3Bp9c8=
X-Gm-Gg: ASbGncvntpbnz3WlBLV/0Wp15FW3QAJxA+hm2QCMj5AyBuvFIqDTQkkhp0imke8Bj6b
 OrXv/jS7R4TEk46UsFm6m+AMaYJvCjxoxdX/2zVX2jxGifNxWmYxFWkf+rfEgCM0GkfcAU3t67E
 kO/Z0ettEgcBiMMwHVRwvCwHc=
X-Received: by 2002:a05:6000:310f:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3b8d94c114emr6412942f8f.44.1754302755954; 
 Mon, 04 Aug 2025 03:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi79g5eNJmk2+zZX/91Ufvi+fPkxwf9rykGoVNEP0VygQtNk9JbhA7TJtpgvfb7ZB5+tQ2nbAiLHfbBMg9Y4k=
X-Received: by 2002:a05:6000:310f:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3b8d94c114emr6412913f8f.44.1754302755467; Mon, 04 Aug 2025
 03:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250801170212.54409-1-berrange@redhat.com>
 <20250801170212.54409-2-berrange@redhat.com>
In-Reply-To: <20250801170212.54409-2-berrange@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Aug 2025 15:48:59 +0530
X-Gm-Features: Ac12FXzO1BYv-T1xUL4bo8G09NmNbUAv5zih3NtBOfpSUGLMMQ5YwGih4bt6sNE
Message-ID: <CAE8KmOxzskHzPsfUCZP56qmFHC7Rgi8x0HacUuZgzUv4UNiYyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration: simplify error reporting after channel read
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 2 Aug 2025 at 00:06, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> The code handling the return value of qio_channel_read proceses
> len =3D=3D 0 (EOF) separately from len < 1  (error), but in both
> cases ends up calling qemu_file_set_error_obj() with -EIO as the
> errno. This logic can be merged into one codepath to simplify it.
>
>              } else {
>                  qio_channel_wait(f->ioc, G_IO_IN);
>              }
> -        } else if (len < 0) {
> -            len =3D -EIO;
>          }
>      } while (len =3D=3D QIO_CHANNEL_ERR_BLOCK);
>
>      if (len > 0) {
>          f->buf_size +=3D len;
> -    } else if (len =3D=3D 0) {
> -        qemu_file_set_error_obj(f, -EIO, local_error);
>      } else {
> -        qemu_file_set_error_obj(f, len, local_error);
> +        qemu_file_set_error_obj(f, -EIO, local_error);
>      }

* But should  _file_set_error_obj(...  -EIO) be called for len =3D=3D 0
(EOF) case? ie. function is trying to read from a file, at some point
it is bound to reach EOF.  '-EIO' indicates an I/O error, reaching EOF
could not be an error. Maybe we could just return zero(0) ?  (just
checking)

Thank you.
---
  - Prasad


