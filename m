Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55184C55165
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpbTr-0007P8-Gm; Thu, 30 Jul 2026 20:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wpbTq-0007Ot-PF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:52:06 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wpbTo-0008Cf-GF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:52:06 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-934956bee57so9471385a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785459123; cv=none;
 d=google.com; s=arc-20260327;
 b=fBxMKMzKGEqM7x+1GVrO6EYsRBvvxJ3ZUWx342g4q6SKdGj9PPmfxY74u2OXKXXDnd
 Wkflww9k5ItrMn6k8CuRV87mO5cA5blPMPVCTDB+bhJzg4HYGqMboYVfrX3I8+r00nmp
 LHxJ/CmW96r4WnpDrxWi5OTcQY03tqsMFpuS0DtQHl917AeCbdW5zU/4ISZt6IVj4nvF
 E3MkwFELkuQh0GcyPHQ606o4SwcunQNaIANpKMNZ3JVdqcBpGq3dgjjeSAkpDWF1lLiI
 CdVhnN7WavHId90JUf1kUX/LGmYdEy5Zd2WOR3sY8YBgF5wo3or0uEaPR72PjbHrWWBn
 1Kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vjMP6aJWfSUMo3nRh7FU/rwRMj+UFQIPHjMaWbFWddk=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=pVxG+7LJKrjLXDp77c8jT4QpxscEKpmDj7N1Ui5eE3FEVhrdRnkmDMwsb6DIyvKe2/
 IiwIUgxggz+dI+qCG+SN7iH7E9jB/GZgqSNuKFqrzVCoIjwE+xpiQax9LjmQU62vmshr
 +UYmn1tKQWL7VoIBqFkCRxFNw7gZyYVhb7Halxc4R78cStMomAe+iIU1mpwOkZbqX/6t
 NxoJZNYzlALeGXjpqliIbTzE0b0FHZ7kTdcLeUKSaCDAzWkFPdWBmHRhaJEKY45R8/RQ
 +ftUEmoRQ5XfYgJu+ym7xu51BtgM0x6wxYaTxMjnxTizBZ9HX/BOGqdCrZHNdbfZoD55
 gfRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785459123; x=1786063923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vjMP6aJWfSUMo3nRh7FU/rwRMj+UFQIPHjMaWbFWddk=;
 b=se+0RwzWn/bAvfzlnNfUsh9KJxTK6MwydjSBY9B7t4bxHaepD33FQsAkvv+/tmeMYy
 sEN1N/sjpsXOC1N9A7esDTalgYHRnPv6cAr3LWpb3cR5lxfI1WhApxdAKqt1MSxLdxoC
 GqWQFi7c/DD/hzRzApo872D8M0KGxqj4jYx7oIhx9sAj9WYkKMojhuS5vnPQ0mhP0e45
 GakgQppSawCFy8AVVmmrTvWttid/qX5whTp0ctamvA9mua3OpVUuWfHbHgDBtbSsuIqj
 1JU+DBP9ZMhD2X2NGihJH7gq91JKWdtb71l8PqP4rLRqZFBcoHaXUWANKKxPpeStusDd
 rlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785459123; x=1786063923;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vjMP6aJWfSUMo3nRh7FU/rwRMj+UFQIPHjMaWbFWddk=;
 b=mbnpTye/KbqrI0r6yI5q6i2hLCnfxIZSUlWO3JIGCZK+frMpmOqnlFKfnbhzZ7vVV+
 Sl+lDkPFSBwvFRpGj0yC7gTOwdg7bRUb78VWaF3JBg1wPwUHnRbCUkdvKLVrDbjIYIUL
 D6Ipk2aAeyRgjph50jkgG543emh9JdF1/MCEMlymDeCnHBaZQyuYLHXp6QsmrQCL7rRJ
 aaRuRYAc/Txk5V+OqQ9JORHONBd7reZb2Rrk2FplgbvIPyO8APNCshe5P2+gM3rNv1sS
 8763RZMC36LEu5H3FCEfYWSBLgVHR0UtIrOCY4E4SeNJMwhLmOg/FyXlZAuE1vK0XkDP
 Fh0g==
X-Gm-Message-State: AOJu0YwRfinJtZxa6i222+aLc5oEjSLAMEqahZrwXlhM1Z70nciiISgt
 znXYc1X3QFXNvZQ4pTMFe6CjpY0tmkqfWIAupR1bVt8k3Z8DpD588f5PFf9AX1KhTkdGUilTscs
 7dkchXTUBtVSD/yswUZIWl9V+yqYRNzc=
X-Gm-Gg: AR+sD12O5YqqFJezY2396RP5O/9cOfZhqWgmRYrfTdArLPysOqptDAZFsUq9irjyiFS
 +aW7UTecBRyaRHQBYGISEF62a07SbNjit+rQXd54emMNnGiSFh66PUDmbVm2fWvc2r64ATGWFyJ
 qsrajrYbMeideR9iC691fnh6i1VWK59cHBiLGJBztFy5MqtbPgs2bZ7f8WYM6hxQof2lYbJp1pX
 UpbOJZV+w8g+LCiiiNe31BuaisKntVLCcMRiuG82fBdwGIWav3nmgxsoAp5Q5qkcxkaB80CBklq
 P8DXmMXt8FSBi7SXswAm4YLZR0B7h41iI3mfas0bu74b8+lmUHrLhD3PBZq2qyS6+kD2QrKvPQc
 =
X-Received: by 2002:a05:620a:72cb:20b0:92d:54f4:dfd1 with SMTP id
 af79cd13be357-9349684cb9cmr10355085a.54.1785459122886; Thu, 30 Jul 2026
 17:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-7-6b97c439eb28@gmail.com>
 <8f37b789-fd3f-43ef-b15e-ffd44381306b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8f37b789-fd3f-43ef-b15e-ffd44381306b@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 30 Jul 2026 17:51:51 -0700
X-Gm-Features: AUfX_mz-tdw8KKJwuR6YxYh8n0iDqjLfDogIE8aFoWVKkljVevwfK-AQZ4XgUGc
Message-ID: <CA+spn3qp_Le_Eym7-j5v8sjdE0i3TXw137oUZrHAnKUuJonr+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 07/15] hw/virtio: iova_tree_foreach wrapper
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
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=connorkite@gmail.com; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 24, 2026 at 4:15=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> GTraverseFunc stops traversal on true, but this says false ends traversal=
.
>

...

>
> Here is an extra blank line.
>
> Regards,
> Akihiko Odaki
>

Thanks!  I will fix both of these on the next rev.

