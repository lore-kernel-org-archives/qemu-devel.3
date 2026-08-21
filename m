Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7ABC5DF81
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 00:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxDIC-0005ZW-02; Thu, 20 Aug 2026 20:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wxDI9-0005Xt-VF
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 20:39:30 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wxDI8-0002XZ-Ix
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 20:39:29 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-92ed19f4d60so25375485a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 17:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787272767; cv=none;
 d=google.com; s=arc-20260327;
 b=YmcYi8sQsCRhnRmiWCJn0+8goEMBGXeHA3W+bepEQSVpCB62PrbO3I/6wNYjnS8OgU
 dyvXt8ngiWYaJxRONZPYBzonbKQMbDNaIsYNUX6l4PuAInhJRs9IBGT9RR7siVgeyQ/E
 rBsMURaL/8p5nGOpycaoWIDiu8sVicpNlos6HdY5wkjwYP45o3Lvoj4h+eSLDZfnrVXg
 WNqXbXr+VOeRZ4RozM8zB1wdX+ytCj7y4L1uronYQdfDr65s8DcoYw4FY5li+78vbLyE
 Ou0fJjx8S7Xl6DGvVd4moaXAMPxUBWU8SZ53WAqUeopH7IX5KlE/rYcp+gYP7QIgPTVI
 1kDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j70X1/99ULtJfEdnx9W5U/uMiQZCyEzvH771g5wfHE4=;
 fh=R0rAHwiivkOkdk/QDnJSOoa1WOW+ftA6Iox/h8BwEu4=;
 b=gjPuRmcza4hYCRDG7meuqy022r9Zi6Snon044U1z3n0jSh/5r0xltGMNTtfqt7kfx2
 LXHDEcYqxF+SDU6mjZo5CgWSnCbiD2AgTSsQHykJKkmlMML8SyxS7IL+duwBkdOTXDjy
 ku2X3KCNfD3AgB3izvhFpSwJ2zjzG5qnt058HXBNtLXvbFybqWW/fFeKYTPJAv/XxXSl
 R8TUJUMIx8znYqld2OnwyjFdTGrwMeXPW3bUsMKOLHhYspels0IqofqLBvAmkoHqBhfl
 vvhaFVEajxWjW4O1i/PjF7GkZYRSILQQAIIGnLZ686kdm5ZvqnQrCQRaj6/azWS1euAx
 KxPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787272767; x=1787877567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j70X1/99ULtJfEdnx9W5U/uMiQZCyEzvH771g5wfHE4=;
 b=LxaxOs2fEvaOPPFG5n7vmrn3W/DGqZsryxHNtjktZ6/oTFHATKZZiZ1tyc2aZJmp4+
 Cu+nAfjnnrK5uRHHKHaZRtXbMK961gu3Xichr0goUXSMAAjF0TNgdPfLIsbVaVz1OsN3
 itTgATQfkdV0kkTAloFWz+ln2b4CtBYwyC34I8POSm8cxiM+cHH+C/linfGQ9K5Grgnh
 iA1Mcoqy0kysKQeswoPJRZoqX7vO8QkmfyUOo7JlkU0ZL92E+bWjq/ltJyXC6mOtqsZT
 Y+J9utyLBjAtx+2HjbcKQO5ItJWwIE04g+vN9F1Cc9D2zmnmYw0SY3Vud5k+iPcJ5VHo
 qBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787272767; x=1787877567;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j70X1/99ULtJfEdnx9W5U/uMiQZCyEzvH771g5wfHE4=;
 b=m+byYkSFVl6qLZ7WBG6okzhQLJK8rCVFvyRjshHJpAXIfeMTZ7Bb3oFsr2AlJj23+j
 IozeoyMLqbpdMkIbpzdyWq4tJR8q+e30Nh7euYGo7gtJUJb1jTpVpYv+0BLial17h0J0
 jd3hi8o/i3SRAH1yjn97Lsz4iq6uDr+DjNt49yCbL9n/1MsjnbNicD3WpNU3As5nFC3U
 vccjY96zYWPIvByy6IAjARiAiyH1nhb21nARGi3erK/c3tYF3vIrjtJPiEMuKs7nB0KK
 nbSj/luaApJWRkW86zo3PjfjePcjQclTNFMX1fKdJRVAXfp2/KwL73t0QpPTNWkGzqV7
 Tr+w==
X-Gm-Message-State: AOJu0Yzcg+aav01zrkuP16CdSk0mW+2t4scSXrXfnYwCxs4eKyy9Y3EE
 QIzbrg46e084NjlNAokMMyPaPzFEPA+02XpmggrxgFI2SQDXmBx1Wk8DTluo5bbG7viCF+sXVwM
 dGDbBgJDXyAIWv9Wkms9O5QyHxif7jTs=
X-Gm-Gg: AR+sD132LRadxpPTJbNZmXXuWC3UQEQtJMG4pOq8c7AIhdFbj+T8/2y9FSFTO0y+WRz
 rV6N2XuLMzTciTwYdk0VDALN00ocDnrjGcJumqFL0AHd0wkRbxdb7D2PScwRHlKd54V3ZW0yjAw
 8f9H5D9O53EF8RPJbMa6SDQepR57EnI2RIomsT5wBMLDyVqdX0CH7OLZ9jdkiDvqgCjEGdV+9/J
 fy5HJsYWWu9MG3tu+r5QzszRF2H+8BaRIEdYegudhJVmT3Fki4MlNV9nC93pBVDJDZy6f/GPwwr
 6dPZ4rq47TdKhOdsr5EWb6Hyss/jR9NFugL14efn8C1NhLxLV1OVLnPaEnD7RrIonyFrS8ip5R3
 PGGU=
X-Received: by 2002:a05:620a:600a:b0:92e:e601:d238 with SMTP id
 af79cd13be357-9373978e84emr205763185a.10.1787272767594; Thu, 20 Aug 2026
 17:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-13-948aae960abb@gmail.com>
 <87lda12mhy.fsf@pond.sub.org>
In-Reply-To: <87lda12mhy.fsf@pond.sub.org>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 20 Aug 2026 17:39:15 -0700
X-Gm-Features: AcwNN1WrRaBcGhG63PkCW5nddEDBgRPe97ID1cUOrGwzNYdpOnePhPHAXOe4_q4
Message-ID: <CA+spn3qK+n+buANnmkT6J8Yu4ZbwS_CqRbisE1uOmNsn1835iw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 13/13] net/vhost-user: add memory isolation
To: Markus Armbruster <armbru@redhat.com>
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
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=connorkite@gmail.com; helo=mail-qk1-x732.google.com
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

On Thu, Aug 20, 2026 at 2:02=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>
> Any guidance on when to enable it?
>
...

> Likewise.
>

In both cases, you would enable this for added security.  There's
obviously a performance hit, but it prevents a potentially misbehaving
vhost-user backend from reading or modifying undesired portions of
guest memory, since data transfer occurs wholly via bounce buffers.
This may be more useful in the generic netdev vhost user case than it
is with the passt version, but the goal is for the mode to be
accessible for any vhost-user device.

Do you think guidance is needed here in net.json?  I was thinking
that, if isolation-mode gets to a point of being merged, then
information like this would make sense somewhere in the online
documentation, but I'm happy to add something here as well.  I was
just trying to be similarly short and to-the-point as the other option
descriptions for these structs.

Thanks!
Connor

