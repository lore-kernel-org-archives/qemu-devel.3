Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179ADC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGv2-0003NS-0v; Wed, 12 Feb 2025 12:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGv0-0003N5-S8
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGuz-00087w-GU
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739382780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhELLUx9YoGh2j2PYZFqjIhRh4apteQaSGqRWWcjOgI=;
 b=PD8nlGvnRRpMj4ZEeU1Z4jDvs07+Bj7Fuu86ESvEwfFpRn4aeemjUFN+LqvDXMGhuSAfq+
 R7dx+MtGbEAiQwuUv+fWOf9ftdRMmRVoaRLERjEZ6r93Ol0Z3dt0cVFUyoRScwZG16xA43
 vE9ea+LKHuAwAe5pFjVUjbMgmk+SS1w=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-3wY_dbh_MGeXzjLbJ2yzyQ-1; Wed, 12 Feb 2025 12:52:56 -0500
X-MC-Unique: 3wY_dbh_MGeXzjLbJ2yzyQ-1
X-Mimecast-MFC-AGG-ID: 3wY_dbh_MGeXzjLbJ2yzyQ_1739382775
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-726cb11e531so3664146a34.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739382775; x=1739987575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhELLUx9YoGh2j2PYZFqjIhRh4apteQaSGqRWWcjOgI=;
 b=exrrTOrC1RJx7pKMckEMeFnERtgHPwYSqt/H9YLWyV7EQkzKu8/rUfm9MhQIZJZE71
 u5lwaSk3oyYG+hs+T2qyp8s5Yeyxdm0VPbIKfH86RmfwE8IU2AKzYBfSrxL2Ku2P6E9f
 ou3B6+KL17KSCsRUhYS3xdg4zlQrAIPgFf9IytgVikR1JaaqWaVLspgUPlGh4SfttNa7
 S03qCx5URCkQB9raP06+PtEPuUcHopTNDopcp53y1KqWb7Nu5gTZ29KLsXKDur8R8Cn6
 Tk49DfWItEYOxJ95+zLN8umXVOth2QOBUHMtuviL4py7tG8C5Kvbs6o7kmRQEuoO7GU8
 5u4A==
X-Gm-Message-State: AOJu0YwTloRnN0tLm3S5GfBOvSbzgZaFo+ntBwZfCwVcmpDrELD+wjWe
 FdRX1AhZ5LoE9x41050e17f4XYy0tUD5uyPVfcIMKAPlXBIGPpzlg1Dj0HyYM9/e3lB0LOeYoTm
 BGB9bICM6Aq7SIpdWpQ5ImcEKvfOGkPMwbveii2lV+bBAgk3Q0qQm
X-Gm-Gg: ASbGncvV/fgHt3qklp7LT5NIeSVd6gZHL6sr5LPHjqtYD/VKA7rLHJqTXvdmZADTa86
 EIGuYz4HFhnzpCeTd1/Vv4HlIineOON9woGaphzXOFYD2uqmUpF5DZH4zk9ccY9yDrePbrLMslO
 e5VFoQcKwfwFcejdRTpGPWqts/XfHV4KwmXmy2zuyT/ilLkX0bTWfKetveHpyT55pMl//UTbRJa
 6Tx1EavH7ze52BMFw+xYdAAktQ91uvF4fG3XLzmN/zJtrxXngIJesVAE2M=
X-Received: by 2002:a05:6830:440c:b0:71f:c1df:12c3 with SMTP id
 46e09a7af769-726f1c1e679mr2525505a34.8.1739382775457; 
 Wed, 12 Feb 2025 09:52:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX69nOnbH3I+3fLS4sfOhAmU6AlC8iB2/7V0t8hVtaLBxFjVbygzZ6ELUSMUWrC+w7ZVI4RA==
X-Received: by 2002:a05:6830:440c:b0:71f:c1df:12c3 with SMTP id
 46e09a7af769-726f1c1e679mr2525489a34.8.1739382774903; 
 Wed, 12 Feb 2025 09:52:54 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726af932a55sm4730572a34.16.2025.02.12.09.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 09:52:54 -0800 (PST)
Date: Wed, 12 Feb 2025 12:52:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
Message-ID: <Z6zf84XtuTcVNyuI@x1.local>
References: <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
 <Z6YqstgG2bSY45dM@x1.local>
 <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
 <Z6owYoktb5nk2yRw@x1.local>
 <CAE8KmOy+C7QzDHJ5hfWg93zSV0ctGYYz30qsQTe-=+iq1vA+fQ@mail.gmail.com>
 <Z6tqq5jpbDHsVtVw@x1.local>
 <CAE8KmOwxobOtw0B4UVECFtgTdbMtOU2Sw09WqYryYYzG+d_UJQ@mail.gmail.com>
 <Z6yyRdDabvoHrYsm@x1.local>
 <CAE8KmOx7K1h+_99ivNFQENJNCRJ_rnJVJrdP8BP7zqbRMZNTpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOx7K1h+_99ivNFQENJNCRJ_rnJVJrdP8BP7zqbRMZNTpw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 12, 2025 at 11:06:00PM +0530, Prasad Pandit wrote:
> * I was going to send a revised series with these changes, but will
> wait on that for now.

You were going to send some changes that you don't yet fully understand how
it works?  How would you do the flush in the new revision if your existing
code crashes?  Or did you do that in the revised series at all?

Sorry, no - I don't think this is how it should or could ever work.  I've
repeated myself multiple times, I'll stop.

-- 
Peter Xu


