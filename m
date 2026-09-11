Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CE9C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50m6-0000Jx-4s; Fri, 11 Sep 2026 08:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x50m2-0000JW-Uo
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:54:35 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x50lx-0001uQ-S8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:54:34 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056be4d2so708969a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 05:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789131267; cv=none;
 d=google.com; s=arc-20260327;
 b=QQTwaRWEDapm6Non33Fn6w6lkf7xK23beuwmQ0geFTNdPJMxCdY31ekRdwQ+eL4Ufo
 Jw3L80QfwbzWxRPTghwEC3V5gblc+6NyvUdN5jUbhSur9nZIkaT3FRIvW9eai7iFpjxl
 TP9AVXSSIyUoFMb3/E/D6f8B75KjlqNHiLNKNEyP/Y/W0stao0GzcXxLun4iE0JuprfL
 5A90OECtFiXZZSscxkMG3x0H3Nb3BB+zSO/cnHH0QvXJBVaLCYNVSZxl2mE0ST5Y5pHL
 gR5PXY1KerWu+B2gH33qsvtn4Eqqv05pqswYy25+8PX81jJTA8Jvdrs77psDgr2vPQ+W
 VF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RQJNBN7xXsWdn00WVqHCo4xdtCx4SHmad6GkyAortV4=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=aHtH5QLX2uu1+mvFb+qRsy3qdpwmqB4n8/v/1BJuycMIBhYd5kIs/TfsDOJxkri9pK
 UJNFdsTgCLagd4DQns41G7lC+wXwA2tL0qjUm7JLM149WMjokm34u611ZFZ6OzZRCQHv
 bYtffAtNGDKQzNRsa9h6AjPgl2bSZ9PFmNA2V0RlrwZ/1164boWmKAUYPqL5b+RybJS2
 z/isDSH8JZTdnizlwwkg7LgtoWGjiNm8rf7rXDaIZ+ht/rdhdVr7kbLXs0KkjyE7Rr9m
 WK5T24wXEV/bRDJOBgAAJH6VISaGON0VkKXhJ1J7sBPMSQJxQxeCneNHMQ0vd/B3AlQe
 FH9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789131267; x=1789736067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RQJNBN7xXsWdn00WVqHCo4xdtCx4SHmad6GkyAortV4=;
 b=XKcUtzSQ8wZQNxGvWQgovmnZGxeLQPD+45sUfUqM9qNiISz8tIPZDpSUVFdByJnNnX
 PV29/D0u69Gn4zL/gIaCsnq72YDPHS7yFXGJr2Q4zF/PYajsjPqUEyBcfby6aIoBxQhR
 TkVD7en5kXxgJmNXhTO89KBWkh4bsK8caf8HmsGHHctgPngRD9sk5lNIE+FoUHm178b+
 +7LwQDAp2gnwAgTxbKnBh8XVAPFsIhpykzaAdZ21HJ1NOZ8QTQ5Z0ShqmV/7Uyqemyyi
 bDQ2EpWcMSYTSuv5/rhd6fxyz6UM+TYeyjZXtQc5EbvSeXeajAER1T26RcA711K3m8YL
 vPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789131267; x=1789736067;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RQJNBN7xXsWdn00WVqHCo4xdtCx4SHmad6GkyAortV4=;
 b=YmU+WNNhW2rYe6jUNUldcYLvr5rYdN8wPVxMtoPvmGvGp6cBKcWzUlVUNMCV9N10xW
 Nqezm0z9B2neMUEPciPrX22sJX9wFqoxKJSHvw+viSVLAx030JCC44i+/ld0XdGv4mP3
 icPQ3xVORNF7nIylEWGCTpp2xi+nVsqooDuIuMH5ZPBLj1KeSVbcuHdsgMerj5hzTBxu
 j9gjdKc0dhN3OhffBLAPQW4c/Fgd/LKp2P9q4dPHOeuVhXPH5NbTjJhksqwZVL+Rq1Gm
 racbaYYZ9OKC/3Gipup3b+x/FNnOt8LltqeJvl67yJDuH+ZO4MIG2Wxs+NxERx3XDy0/
 giZQ==
X-Gm-Message-State: AFuF++lMEkCL64C3cD8KFtHYGkCXcxvRhiuRYQrSk7ajHw3hjFXoB5Q5
 mv7mUsPLzpnKaIs4ke81xMrAkHPc1wedcLWqndpQZb4UOSxk2X87dxIgkBllMVyRT8NwLJ5gTvG
 nJ7V8BGSxPHycYywMx/tgUv+Mqb7cCxI=
X-Gm-Gg: AYBFou1AIFdinJiHMaPzW5CYTsxObkym9o7jPcSewAe6ER9/y0ispMaJC1yzqOkgTjn
 QVdKoyWHedes3UXf/M8nlNbGWQo6B0mp6teehlxYbu0xvVumHZIu4sNtBgjTDOCSJLU/wOZC1QW
 xZip6E2zDNP65OYWGYCxvdaAFnOCXpNpsPUwdoucn5WdxquXLLD8wb+kGNHJQ7OC8TvyX3V81LC
 VjN0QB6IO38m4Rk5GGk7bulkW92MnObkQsMZbOWVs++H8WFHancoqB4pEmTJ4DCeF3yZzo091Ra
 Ub/UUb4cx43FKxd2CqtPYe8hcEZxXhdbnjLsDDdfrGTJnbdWInIluhc=
X-Received: by 2002:a05:6402:450e:b0:6a6:b2b9:61fb with SMTP id
 4fb4d7f45d1cf-6a9b50b1b62mr2007254a12.15.1789131267139; Fri, 11 Sep 2026
 05:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260911100709.726366-1-zhangckid@gmail.com>
 <87wlss6owr.fsf@pond.sub.org>
In-Reply-To: <87wlss6owr.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 11 Sep 2026 20:53:50 +0800
X-Gm-Features: AcwNN1W7GFt2UplD1lcrKmzlfA514WRQ6znx0e64O1flkH2M1aAO9WKfv1FVVTs
Message-ID: <CAK3tnvKXv+HdK4d5KXXNagUCODj68A1XRuP7VTpZNyUFoMTQnw@mail.gmail.com>
Subject: Re: [PATCH V16 00/13] iothread: Support tracking and querying
 IOThread holder
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=zhangckid@gmail.com; helo=mail-ed2-x10.google.com
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

On Fri, Sep 11, 2026 at 6:52=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Doesn't apply to current master.
>
> https://patchew.org/QEMU/20260911100709.726366-1-zhangckid@gmail.com/

This issue caused by the dropped patch 1 from V15.
https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg02947.html

I assume that patch will be merged before this series.
I forgot to mention this earlier, I double confirmed no other problem here.
please continue reviewing.=EF=BC=9A=EF=BC=89

Thanks
Chen


>

