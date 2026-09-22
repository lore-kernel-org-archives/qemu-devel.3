Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D2BC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94aH-000221-7l; Tue, 22 Sep 2026 13:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94ZU-0001p1-0M
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94ZR-0008Fn-UY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790099181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xB0VdGjmuHuXZmi+LIdPZNLU9gjo6gQ/lH1Fp/WLkM8=;
 b=Ioz0GY6JU+86DZfQDo1ULOoiPeuHfkzAL7DfeUkPVy6rSIFDW8MkOe0oUmSZ4pS5DfxT0H
 7OiFrAtg13nmDJfolXuvyvvZ0xFmV9yhpr5p4i5/+knb+elaK8/FQvDuh5sQLE9tNf/h8n
 bwDRfoXhB7Juk5fcAm0V7LZtp/zaSBQ=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Ls52dlGdMx-Ec5qInXbwkA-1; Tue, 22 Sep 2026 13:46:19 -0400
X-MC-Unique: Ls52dlGdMx-Ec5qInXbwkA-1
X-Mimecast-MFC-AGG-ID: Ls52dlGdMx-Ec5qInXbwkA_1790099179
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66fae2bc827so61115d50.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790099179; cv=none;
 d=google.com; s=arc-20260327;
 b=m9FwS2sBTilJst2hC15mYBIRZL6mGY2c98JTaeDU3t84s9m5vss6JaUCz5f4leh3pJ
 jp5L0talh8wvBFsv9UIXyxKDiyTqfnCEHJh4pO//pzKnD0dIwNdZSYMePl1EFXnlZ6Yh
 6A3XmBakht2lU6L37TL/cEuthEIojEyUMKs69r0ocBE2hSpvp0llWu+b+d+qZgGVznQ1
 9kkZNeqYc41EQ9j7wU4kagMt75nWbFVfuLgO6EQX4eYqrIdp1/X8KmB1DDoPFgWsowFf
 Hhr2Tr78c6jLjMnPMICSGmzAnp7B8D3+I/hOMjqIifJwGWnVx6FXgIscOK3GKXM2ccm4
 2Dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xB0VdGjmuHuXZmi+LIdPZNLU9gjo6gQ/lH1Fp/WLkM8=;
 fh=4SpBrKxBueTKlh2nVNOI1f4PgGJNaXa+zdI/ORe/sas=;
 b=SSSLKmaPQ5cOERCLfHdMGE6oM6aFdHdrcDjXObBnyDkEOR2ROmr3hhxCrbmNXrp4Jg
 rr16075B7p210QQeG88k8UyrMcPkymr4K2NQz/xLxs+wyPXT1LCh7Emw91rB8IiCSBxm
 IbEAH28RpogAZFC9mmo6u1bkwetUUQawmRlbwnS9DtWAYL/TMWQJrszYgI2BKyitPM6p
 ZTuD2o4PSuIBCEF7LSoCvI10NO7o127sI/OIeFXwAUQA3qoNS768tnAlGuExYGij0WC/
 3IhnGSDgpcnL4wu9w3jmAiWcmXEdpSQj4SYq4ZtUY3x2urhlqrNVAhXq/BrRmXzIMMyN
 hLVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790099179; x=1790703979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xB0VdGjmuHuXZmi+LIdPZNLU9gjo6gQ/lH1Fp/WLkM8=;
 b=R5yBSxcIeyFk599Er0SxnsDGB44HHdigpfDbJ4cFI7osuc6c6v5yneFt8o9+afacqA
 h/6tHtRjtu9APD1jvzXDG1amH03JJnDe3WMNfqZ96oDPHhW7fFOTAC0+yTDqinG+8HSk
 gEvUgdzwlzXsFato6TtZDEqApyFbcW6igIea4SXlIH9t9dac1sOYMX/LbupfQTZjY50J
 zfLk/EX0K1VeqO5fr21zgqR5pdGpAgBw9+/43s9QWkuU80RTVZDJOFb5yim4LS4QSVGV
 6amO8o0ICkhFpyWpblip0V++m5GzFUR9fmmUG3x/+MtG53vP/ZRx1BQDn6YdaAVvGJhj
 /u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790099179; x=1790703979;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xB0VdGjmuHuXZmi+LIdPZNLU9gjo6gQ/lH1Fp/WLkM8=;
 b=Us53UUWnvSN+HYEEg2FHCZdLkXZsZGQwe8UVF3R7OKEzr9dQyZWfjcr0doesModnM+
 JfSsRAxCjN8V0LpgGlUeROTXfv93XOcTkbRtcP6G6tHQDVvn6bQTr13hMb0uz9gRxbwK
 YclU7Tz0LOUkC3bGhvvDI+RC8mgyJr45hhJke0QI9gCXbvtzB5gZzYweGvQVqwLL1R2i
 ZhqIUY2oq4bwdYJneKK5tCRWx3A+WtbvbqGQa8+iuXVxv1lEOZRvM0ixFrijqUgBUNJ+
 D6wrecy2XHvuxYK565vUjMMw7uYLl2+R8hz0ki1rvG7EwKXV3uWJ9EdMN5mZ1jC+3qg9
 /zDQ==
X-Gm-Message-State: AFuF++lz++XmZsJcvoQ+iI/Rt3tm8uIyeu5OATzdcKqu0wLcSP8qf3zF
 wA1P1ktoWI6H2h+KWFs34ulwW7cnMWPqabf8xGBAOEGzV2XevuiamIhC2U3RZjMtcvOv5c+sVJ3
 hun+nCpNEzp9G4y0CAOAlT0xjvNf9B8eQawExZjr9hn+cLE1g/JpknpfFuI1+lbbsWjirFvThTa
 Y/EL0+Nc0KT78HbsKAKDIeYlLcS8KdNkI=
X-Gm-Gg: AYBFou2rHXk64ibUWm/vOBOazRRuRGImDeikKk/UyHeAl+4fO21se/zyJ3fBZ2e9K+3
 G3e7cKCFOzySsZu+oio95qnCwgPMzNmWP+kR5u9ohf87j1s2A+4AEy9QT9BT6ibN/MvNd7C5skn
 ut3AaurfsOAlTfxeTRnjoMbEm9Ui65rfQKzHnZU41CLCzXnYx+jSdj7Qj/hwqztDl/f+3icCSrS
 FkGYjGknpZsI3eD
X-Received: by 2002:a05:690e:458a:20b0:670:f743:6ec2 with SMTP id
 956f58d0204a3-672d5897536mr98769d50.60.1790099178566; 
 Tue, 22 Sep 2026 10:46:18 -0700 (PDT)
X-Received: by 2002:a05:690e:458a:20b0:670:f743:6ec2 with SMTP id
 956f58d0204a3-672d5897536mr98760d50.60.1790099178154; Tue, 22 Sep 2026
 10:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205147.1857168-1-jsnow@redhat.com>
 <20260921205147.1857168-10-jsnow@redhat.com>
 <875wzx2ovl.fsf@pond.sub.org>
In-Reply-To: <875wzx2ovl.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 22 Sep 2026 13:46:05 -0400
X-Gm-Features: AcwNN1X3clkubVPauZPhIEb3CKA1FY04S8lLG-_q_3Twr1zVAF7I0w5qamCIzHo
Message-ID: <CAFn=p-bhYcWQq8qxi-STh4wDwvNigKWYpZ2Ac+apU27s-89c0g@mail.gmail.com>
Subject: Re: [PATCH 9/9] tests/qapi: generate output in source order
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 22, 2026 at 1:10=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Rewrite the test doc generator to produce output in source order,
> > instead of arbitrarily.
>
> Really?  As far as I can tell, the patch changes format, but not order.
>
> Dig, dig, ...  you already switched it to source order in commit
> 9606414d46 (tests/qapi: generate output in source order, 2026-06-11).

Ah, funny! This is probably the leftover bits we didn't agree on at
the time and I didn't notice that this patch became anemic. Well, this
is just a preference patch now and not really strictly necessary. I
like seeing the "section=3D" text because it's a clue for me as I read
the text, but it's not really important, I'll scrap it unless you also
like the formatting change.

>
> > Signed-off-by: John Snow <jsnow@redhat.com>
>


