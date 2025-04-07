Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F70C3601A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 06:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gHO-0003Hh-P1; Mon, 07 Apr 2025 02:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u1gHB-0003H5-Sf
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u1gH9-0004Cv-AW
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744008484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ol0N92JhvLevLBglZJ5MiNhAftoevB16qQo0rKmma0k=;
 b=aRCg0QBraTbtqyvxVYLDr3r73cB0cHlP93riabTdmPPBYp4g9BN5UufHVkoM4pEMzRbxP8
 CvHoZNfD5DhTtfYz+rwoGsH2ZbO36NVXlQAglX71ZOm3UOct3RnM3RFswZlm2Kc1Rmeiwx
 vIKR6e379TWoHOjlfa4N/5+iWWHP8fk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-BcOu_qhyNcWdXIc5T0WmUw-1; Mon, 07 Apr 2025 02:48:02 -0400
X-MC-Unique: BcOu_qhyNcWdXIc5T0WmUw-1
X-Mimecast-MFC-AGG-ID: BcOu_qhyNcWdXIc5T0WmUw_1744008482
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d01024089so33853365e9.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 23:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744008480; x=1744613280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ol0N92JhvLevLBglZJ5MiNhAftoevB16qQo0rKmma0k=;
 b=c0XTZzgFj6aSulxSvP1E9F6mDtyqLfQOR1C31s4RD64lSpUeCSQUzkO63nqM8tBRvo
 JzrVU0rJqDEWy6QhONQRDORRaWfTf4cGjnGV1e8c4fiyQ5qn3FsKf0upTnREtW6wUc1c
 5YWwqbtLwJfaVBM5SruP+2iGhmI1QUaJwPhaSHjvWc/EPG0UAuQjlFxJh8/6rczKmaec
 SzqhKzR+QaSG70/ahqIXjGI5I6CVTrw/tkfZDfgtXR8gqy1ZUx8KsRlIC1VyorwsdZiQ
 GnN1rzjXtYdjxtEq4yv1f0lP0CASnXJyv7pMHeKomoXs5wtMBkwkh+dbVfful8Xd+mSc
 5a9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVymhEJkrZdIwo8ueFtPCS7yF+Xy5fp8reUEP0zQjOAaNhRZRCmaIE5Cae7dLPVycle1MbPFbt+wCHn@nongnu.org
X-Gm-Message-State: AOJu0Yy+XxMfqlSb9DqpW52MfFRCCP8DmfGgVJAZLQM+H0OECgZuv+cn
 yg8Gr6Rir/DdCOFymWspdP6zd1rTRRtBvsi0gi+MZAFhYEAfpAdT3dxW/5pz3Yc3UqAFXYkByVl
 nYmjnrr/rVW5vsW/98b4qHqbluO2hggN9FYSN07WT1lJ8SpMe0UQ8v3A3PROEW0759f5gvIheh+
 dWXy7sW2X1D/HVodgmDZXYDBmTHeS5jdBxYgwX2g==
X-Gm-Gg: ASbGncuwhtFpTbYURAwgzlWrkWZYlLG+8XPgwGkrLr68jVWrcoLLV2mWkUYM57Rqfw7
 QwKJ6jk0IYHDgWp513MQej4ojsXaMLTU129zd5ksk8Vb67ahibI4I6WuNCDvBJlAHMxYczRtcXn
 k=
X-Received: by 2002:a05:600c:1549:b0:43c:efed:732d with SMTP id
 5b1f17b1804b1-43ecf8f2f4bmr109816735e9.16.1744008480681; 
 Sun, 06 Apr 2025 23:48:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH87tdyhJZWs0JGecVP3h2R1BegGJqMlcpYaGNAb/ccKEep2XwmuBjdjZRoSefk6slJFxE5zvKTnI9zR0EoJJw=
X-Received: by 2002:a05:600c:1549:b0:43c:efed:732d with SMTP id
 5b1f17b1804b1-43ecf8f2f4bmr109816585e9.16.1744008480341; Sun, 06 Apr 2025
 23:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <5ed-67efa080-44f-38bc9540@144005994>
 <CAE8KmOzz2cyHimBXcs79wOOzg2KyKwmSNSXbkJomhGdhwWfKBg@mail.gmail.com>
 <5ef-67efcb00-537-1a6bb1a0@222476586>
In-Reply-To: <5ef-67efcb00-537-1a6bb1a0@222476586>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 7 Apr 2025 12:17:42 +0530
X-Gm-Features: ATxdqUH79lq3szunxlwQvUoGMv0Ydn9HjU_RNyDoUwipGCVdDGgRf8xwKofUaDM
Message-ID: <CAE8KmOyBjkFhc-pa-m897S2h+G=vRgkDf69595K9NvogT_oKRw@mail.gmail.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
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

Hi,

On Fri, 4 Apr 2025 at 17:35, Marco Cavenati <Marco.Cavenati@eurecom.fr> wrote:
> The QIO_CHANNEL_FEATURE_SEEKABLE flag is set to indicate that
> the channel supports seekable operations. This flag is more about
> signaling capability rather than dictating the use of the specific
> lseek(2) function.

* Yes.

> In this case, I don't think any lseek(2) is involved, instead some flavor
> of pread(2) is used, which, according to the man page, requires that
> > The file referenced by fd must be capable of seeking.
> because pread(2) internally manages seeking without modifying the
> file descriptor's offset.

* I think  "...capable of seeking"  is referring to lseek(2) here,
because the man page mentions:
===
...
ERRORS
       pread()  can  fail  and  set errno to any error specified for read(2) or
       lseek(2).  pwrite() can fail and set errno to any  error  specified  for
       write(2) or lseek(2).
====
ie. pread/pwrite internally makes lseek(2) call.


> Let me split the question here:
> * Do those functions need to seek into the channel?
> Yes
> * Do those functions lseek(2) the stream r/w pointers?
> No, they do not use lseek(2). The seeking is managed internally by the
> pread(2) and co. functions, which perform I/O operations at
> specified offsets without altering the file descriptor's position.

* If seeking is managed internally by pread(2)/pwrite(2) and co.
functions, then that is independent of the
'QIO_CHANNEL_FEATURE_SEEKABLE' flag; This flag is QEMU specific, it is
not available outside of QEMU/io/ system. pread(2)/pwrite(2) are
standard C library functions.

* Another question is: will pread(2)/pwrite(2) functions work the same
if we don't set the 'QIO_CHANNEL_FEATURE_SEEKABLE' flag?

(what I'm trying to say is: it is not clear how setting
'*_FEATURE_SEEKABLE'  flag helps in case of QIOChannelBlock class)

Thank you.
---
  - Prasad


