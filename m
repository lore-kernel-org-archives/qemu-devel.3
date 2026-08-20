Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DCEC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 01:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwrF3-0003an-Dq; Wed, 19 Aug 2026 21:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwrEz-0003Zi-2C
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 21:06:45 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwrEx-00034s-JT
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 21:06:44 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-92ed3993c1eso107468785a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 18:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787188002; cv=none;
 d=google.com; s=arc-20260327;
 b=Fl9+AO3DACfJImXncnwiHl+5lPy7CAeJqkf4Hct8C65WPABbgaKzzvdkJlWcda+O7z
 8ibYoCS0xzO+KjSEOsi4I40RiuLtk96Moic88LhjKG4lgoGj0xgfxI4V5109WQj7AeUo
 Q3Ag6V33C/IAiZ+UkeZGm5no2/9L1G2Pb8oOrbffvDPlPsrMsm0u/rXJlT5hDERG8Jpn
 3+2YIgkVT8Hi0P2WDGqKh5OzYsrgLi8c85L156A/tuHi/j9Bvkc0aS21hS83o2x9eyP6
 BZfbIC7PkjwTqPJmAjerjIqx0xZFw7BbviJXB9se8o/pLKtLNTB4gf5AuabBr2nONQNR
 jGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vsWCscNzkxiVMmU/QBKBdlqpIVF9XvSYTxKTjjRPnYA=;
 fh=JLmbCqUWYmVW9X9vBHMbKGXTZydqTLdZloMZVZzLFJU=;
 b=LhnkgP4dKOXJEpvpl/2sCe8q4iYbL+EydFtMnsLfqpEyyo49a844cGvH89IKECh9HW
 ZKu3O4LbYFzzX9PpTBreRBWza4ARwAuFJou24YLX7TAEF1wKPplUDulcIcuq6/agU7nF
 CUvDJKPdiRZ+PiePJyPiMt1EVliLmmSK8JWXrQGwoVQTGi8XUndCbrNJLa7kVAF5fqTO
 rtIE2zxPoX6r1c4FGpijJ+RrVlE8fa6rWCKgU6U5kUZALMXpdLYS928YWWYqeHr4KtOL
 RsQd0RDq5srJJjWqfEFhKIhjXxQevDfGUfe1TCcZDL9yUmtb+rz8SIFxrSrwUXxeIqCE
 W/BA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787188002; x=1787792802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vsWCscNzkxiVMmU/QBKBdlqpIVF9XvSYTxKTjjRPnYA=;
 b=cn1fLK8eH1AUurjoLX1+eVSeK/PxiRnosMzcIsq6M2LVx2MuvK5zZsHKR1nZbT0fyO
 lYloQKtrMS8DfiuQM+dFz42SKafs1VijEvK1R3wxprYIPXyU1eDd335kaW4X81HtnbTP
 9R40JO3f5iRNiZzPFGUvwGVxOQRA0YA8DRvXor2vuGc4tvKP97dLEi+0jTidNpczG9VS
 ZkN/rmZF96ONa9hWJW45gObU0R11o1uJhTRF82B4X+MJh+I3fWpT/e817tT+UXvdIs8/
 aUI8+rXeG1/cw3OHk1cRFWn4mPnDNy24pO8jAyWxFWSOY87ipiR9kE2iuolRjcJTNC8h
 3d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787188002; x=1787792802;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vsWCscNzkxiVMmU/QBKBdlqpIVF9XvSYTxKTjjRPnYA=;
 b=qUgGCj09SLH37gPTpoqdL8TDlna9cSTJjzF8F5E2PHTBU7oTh/i580ibHwOGqDTl3S
 vilC71EPPQoLs6VBnb19hC69KZQ69KLZAVbYsUPJuTn9QufE78qubup1rqCOQ0kEgi3D
 S0b9EAldcYUMvv+km9jSPAs7r8NAj9hondGvtNxaF06Ubc5scPfJIpyxAzCRQbvilsvt
 FB8Dbrt+kYEl95uARNiUCGUFEl/3qd/LCRfxf/3I7xuLrE80D6ojvKLAoCMt9xQjwLdO
 n/zSG+rQwmNnXDrxCt3aG3C+Mzlyk5XHBXAzJROtG3gwRkOxFVV1mIJMo2rKF1sUmwjR
 smyQ==
X-Gm-Message-State: AOJu0YxAaizSADjrKu8gc7edFdgQxxEDUTlbd5SrBvTLJMBnAT9bkRfu
 URdrWonzocpm071FkS0A96jfv0sCHSbVTCBUMreSNt2ApsfTV41grzr2Sd8LWjjIxuEBOdUPEDN
 jxzZFbcKsaL9QOnO4AT0XR7gUcRE/w8w=
X-Gm-Gg: AR+sD12Ks/WLl/aNU6De2nMqELqKFkE4UBkfU3r+tk6y7JOKkB2omTe6GfE1M6B4bg6
 VxrdOZGNLJZX2klKKBrc44TJ8XjLekqs0kTDeZLQgBV/m8rN+9uq+YOmMI+g+8k1cl1NELkvg5l
 hLOBMZRsBCCK9/QkGfOsBmrB02VIxBNoAdsJaMeQDvpDtGmTc66chYGqs0XiXanrZesXEewhuDq
 hQKroD2qrrvZMHNfVV+J/8hYb8Od7nPEYZ8pd6HQVaKod1iaARJIqjqIBc7yLY/D4yNwlv+KUwe
 AAnpEuEAaOopdjJSC1m9/y0cHwMhtguscKDhsng0IGYZrFLqD1PvcDP7iPGJVav/HRDCgB0IG5p
 5DSw=
X-Received: by 2002:a05:620a:6015:b0:92e:7cc9:a888 with SMTP id
 af79cd13be357-9371e2cf759mr924864285a.2.1787188002133; Wed, 19 Aug 2026
 18:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-4-948aae960abb@gmail.com>
 <b6f79ec9-7842-47ff-b210-855036712547@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b6f79ec9-7842-47ff-b210-855036712547@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Wed, 19 Aug 2026 18:06:30 -0700
X-Gm-Features: AcwNN1Vitk5XJi1kg1YAvcpdy9Kk9-83pUVn-HXmmhlZta59p0cOti38aI4rTGg
Message-ID: <CA+spn3rouMQ=yG1m2fS=vm40c-zWWMZPK+yk0K_ip5iXzLZWow@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/13] hw/virtio/vhost-shadow-virtqueue: used
 callback
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=connorkite@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 18, 2026 at 11:23=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> > +
> > +                if (r < 0) {
> > +                    /* VQ or handler is broken. Do not set guest notif=
ier */
>
> This comment is extraneous. It is obvious that event_notifier_set()
> below is not called, and it is same with the existing error path below.
>
> What matters here is the difference with the existing error path. Why
> doesn't it call virtqueue_fill() nor virtqueue_flush()? They need to be
> addressed here.
>
> Regards,
> Akihiko Odaki
>

Here, apart from not calling event_notifier_set (not notifying the
guest), we are also not calling vhost_svq_enable_notification, so the
device is directed not to send any more call notifications.  If the
guest isn't receiving notifications, and the device isn't sending
them, is there a purpose to flushing the current element?  With the
current implementation, I'm not sure there is a path to re-enable
calls on either the front-end or back-end, but maybe a case could be
made that it's good hygiene to flush the known bad element?  For now,
I will add the calls to add and flush the element

Thank you!
Connor

