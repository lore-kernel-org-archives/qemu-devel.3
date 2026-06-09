Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFB0CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxoI-0003aR-BR; Tue, 09 Jun 2026 10:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wWxoG-0003ZL-8g
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:52:08 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wWxoE-0004ak-I3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:52:07 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-51765531803so2685651cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 07:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781016724; cv=none;
 d=google.com; s=arc-20240605;
 b=COJ9ejJhjiqIFU7pUyNWHaZU6ulpZlIVH76zt3NIK3WB6985r1oDVxyBNTitEFOBiV
 v63J9yMNUP5dKzyq7Qxugs6JD1y6pGQtS/uSfSEmckuclO1QiU5Qg+aoYj/Z/br5kXVn
 rqH/m/go6UwOenkZgelwRvekfrM++HZkVmw2z8cinGjlwpOHJjqwQJ+idqN5zsXvWbHL
 /7fhcD4xjjsxiuvCVJwI9zPYIC5jkrOoMMvIM7zh6TXDLQvK2ay3oG+Gp0pQilhWpv2T
 437g6gDWkOGVBvtw02PcOmHkH0HmaZ3SiXkkURktEGWTWJUgfBib24+aW+mk6CQOZm6u
 1YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mT7L+1cUtlPaahWEj6bhvOX6q91ZJhOLDtmYP2cxvEQ=;
 fh=NfmIKIb3UU8XuMY/9cWO9YgUz4g4wTahfFOqcpRp9GA=;
 b=Yt8ZD5pGPbhgHq4YSjI35KfUOzwNdGM+MIGpqM1T+IPzekeAZvAS7IF4wJOvxBDETp
 TB2xnR8Tv9wSF1PqsH+jFyFC6aTSfmcc8u1MdU6PTOOhPsddmTeJRA3oTbNChDF+pYX9
 cGYmjv1ez29UYegyQRCvGUCpMhkchiG1Pkocfh5U1OFBZ8uJWAWdEJQPR4Onx41NT1xL
 +JuqcoQTQSd52Mfap2vDDC1RPrICcTlVVXG9I82TWFA75O5EVIIpunUeE8xel7fihg9w
 PnJLrwVWHZ+Mhy5bcb1Ujd/yTuz8UmJVs6km5skWiX0lR1HWw1hx6N6AHig5wS5yI79a
 QoMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781016724; x=1781621524; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mT7L+1cUtlPaahWEj6bhvOX6q91ZJhOLDtmYP2cxvEQ=;
 b=guptycxe07D+Q47rkyJz8E6G1ni5nvujk9MaDtRU9zxbuC632g03ATblufsNM7Nqgo
 Chnak9yjXXvinFHV4DlVziqv08nreyXkmLLhIRn4W+0CHmJri90QB3x8E6bi0G0sNriv
 npLlX2SH1Htp9qpVm9Ydn6qFreiE/dqWHuhhmDu3Nu32K9zw4R4eDd2S9vMG0gmNaDMW
 wNMY+EBSdtLjr2S0amoLLPzo2agmPLXVFNFo7cTx6J2ezyQFzw+elAz4iZC5F9Je8RFU
 1NKPmbMYzqYSlPZbc8VMNUD7o0R7HKAkWUEUBvNsUGX5vdDOkIqFtr46Rz9NdbLi3Ftj
 9HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781016724; x=1781621524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mT7L+1cUtlPaahWEj6bhvOX6q91ZJhOLDtmYP2cxvEQ=;
 b=DKaitLt4ZtCjvWi7bMs9n122ZfnNxRimo5ctUWQ+7ir/s3LFe61xTU2aKfDqyTmvg4
 Sl01GSG8AhPWHXmBWv/4fhvPYuTcyxK+LxXldCyRXikjXqDhhCyMSB7MplfEVMp7A5pN
 b7zowtYbnFyhRV/uL+3OZlyk+CfsGK0J4h0ts9zahfOmzWVKlhQrHFyTwqsXlhB80Ua+
 KOhE++r9fyEOzVU1ZdSNS+xn76cLgSj9k4uvYvrU+sMsQEnJS70kbhNOC6iycW/Al/FN
 3xFYMjDQDIf6uh9rrwIelA6gWCwlh+uYHL9sUE+l3z4hC4aMIBoijg9neLF3LbAzkz7j
 m/WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3PMCXak3eowoguO9iFgS3ip2o0fnn6g8LW38IuONWWHC6EShRex4vUtn0KwsYsye2XuNsOBIxG+AR@nongnu.org
X-Gm-Message-State: AOJu0YxVXJTYrIl0jkE6S64jSs5GzJEH6+4LZoYKE4v4hy65hBukrj1a
 BscLznNpBI1T5aJzL5yOVCs/qZkSjI+4Zeedgq7VPkP1OyBfDVuKxrWRS09LTdXVJx1j747Y4E9
 NqMs4I8zmZY95A3WwkuJEBHe7ayKV0F/JUe5DaVFQ
X-Gm-Gg: Acq92OH8bw8FHtjmqwbDOqJIh7E+tdvCBrScHb9FWT+eCn7AUpRwV9oAWd8toR5UPY9
 aZu8VAfgfgmvfqnYjNm0tSLS3zCxiC8q68Ck2fBEHAVooEz8rdTQ6RXMQNNz0VymbO4bmc5u2Tx
 1miHnK/R+aFcui3YUjT8HDDHi8wncxQXh9DRS6tq2iYCZ7JtxZq2SHAWkeFVfE/oKsxpyhepMGK
 98Zhy2YU8keKLhG9prmKAYpi8vRd57tdj8Oj0G6ZYepNpTu9PEtwRkuZmPNPAwyDbl0eri/nmIn
 Idi4O8i3iC/XD9dvqaRsBDWBfTYvY39usS+oYUZhzroSKOANAQ==
X-Received: by 2002:ac8:6610:0:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-51798298a3cmr32128971cf.16.1781016723550; Tue, 09 Jun 2026
 07:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260609105626.1038690-1-thuth@redhat.com>
 <CAFEAcA9O6b02VMuto8VzaEsVi3zTqNtQKG_RcMaPnNdPXGUBhw@mail.gmail.com>
In-Reply-To: <CAFEAcA9O6b02VMuto8VzaEsVi3zTqNtQKG_RcMaPnNdPXGUBhw@mail.gmail.com>
From: Titus Rwantare <titusr@google.com>
Date: Tue, 9 Jun 2026 07:51:20 -0700
X-Gm-Features: AVVi8CcM3axo7mAEJOZp-nioF3imcVzHW2yLICbkWxeE6AKaOP-rr_nCCejynOc
Message-ID: <CAMvPwGpvpHD+Sx-HZR4FFMJB+W8Rk8LoU0256Q=vwKAdC96HSQ@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/pmbus_device: Fix a possible crash when requesting
 too many bytes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=titusr@google.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 9 Jun 2026 at 04:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 9 Jun 2026 at 11:56, Thomas Huth <thuth@redhat.com> wrote:
> >
> > From: Thomas Huth <thuth@redhat.com>
> >
> > The pmbus_send_string() function contains an assert() statement that
> > can be triggered by the guest code when requesting too many data
> > without reading from the device in between. This should not be possible.
> > pmbus_send() already has a similar logic, but it simply ignores the
> > error after logging a message with qemu_log_mask(), so do the same now
> > in pmbus_send_string() to fix the issue.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3388
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  hw/i2c/pmbus_device.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
> > index b1f9843f52e..6aa608a2998 100644
> > --- a/hw/i2c/pmbus_device.c
> > +++ b/hw/i2c/pmbus_device.c
> > @@ -104,7 +104,12 @@ void pmbus_send_string(PMBusDevice *pmdev, const char *data)
> >      }
> >
> >      size_t len = strlen(data);
> > -    g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);
> > +    if (len + pmdev->out_buf_len >= SMBUS_DATA_MAX_LEN) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: requested too much data from PMBus device\n",
> > +                      __func__);
> > +        return;
> > +    }
>
> I had a look at this bug earlier, but was not sure that this is the
> right thing. What happens is that the guest does something that
> causes the device to queue up data X ready for the guest to
> read, but then instead of reading it, the guest does another
> "I would like data X please" action. My guess is that the way
> the hardware handles this is probably not "add the second
> copy of data X after the first one". Perhaps it is "drop the
> data the guest didn't read, so the next guest read gets the
> second lot of data, not the first". But maybe the spec really
> does say "you can do things in the order 'ask for A, ask for
> B, read data for A, read data for B".
>
> I couldn't conveniently find the pmbus spec to find out what
> the hardware is supposed to do here. We need some input from
> somebody who knows about pmbus.
>
> thanks
> -- PMM

Queueing reads are an implementation detail I decided on, not part of
the spec. How the data gets discarded is up to the device
manufacturer.
There's a separate issue here though that I have a fix for.
SMBUS_DATA_MAX_LEN in QEMU is for an older SMBus version and it needs
to be increased.

I can set aside some time to bring the SMBus implementation up to
date, but for now increasing it to 255 will put QEMU in line SMBus
v3.3.
-Titus

