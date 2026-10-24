Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E00606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HfZJFaZ6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbfv-0006Pn-Sw; Sat, 24 Oct 2026 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfS-0006JV-KT
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfQ-0000ip-0A
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0LOldFKpixMOYV2xWBbBMRaCAotlRj8zfuORlJm4pk=;
 b=HfZJFaZ6shq4EEVWUi2w7N2bvAdi76WVRXdqP03HdG16d0SG73QC8ObLqqmQv+FDIhBd6M
 7Yoa2WjHq24NRJoYcaU7UeVJutmXHyu5GeMa9hnUcMr2AxVfCOF+BWRkm/KEz5p0LphOYp
 +SXPwOHwgFohlcgD5lK0Q0IewGfazQA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-BZoAmunqOQiboC7c5cZvaQ-1; Sat,
 24 Oct 2026 09:20:05 -0400
X-MC-Unique: BZoAmunqOQiboC7c5cZvaQ-1
X-Mimecast-MFC-AGG-ID: BZoAmunqOQiboC7c5cZvaQ_1792848002
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DA471956058; Sat, 24 Oct 2026 13:20:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2E16300019F; Sat, 24 Oct 2026 13:19:59 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 09/19] tests/guest-debug: convert cmd to an qemu_cmd
 array
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>, 
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Klaus Jensen <its@irrelevant.dk>, 
 John Snow <jsnow@redhat.com>
In-Reply-To: <20261019192704.3220373-10-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-10-alex.bennee@linaro.org>
Date: Sat, 24 Oct 2026 17:19:42 +0400
Message-Id: <179284798272.974117.15014061280977829462.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=536;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jxQgKFHdM05cQUVxS7+ESMAuz0yrVESoGSQSWegc5oM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3LBx9KupIRvCC/nhQwgG4a2FUO1hRU7jfx93c
 xaPRJqbeXiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatywcQAKCRDa6OEJdZac
 5S+REACoH1mRw63bWC8S4qQMkYSd78fyWhLoX4N11/ZVMpuS4dWPgeEs1MdyBBmaMFyd3QhgQRI
 A2e22S/wlw6UQCY6M3IZX0LDrPB0g0js7DJrGSK3Dt1vaYQvxp5YctOpyWZT2/cUbHSj0dfhO8W
 ukkf39EcA7Ztywx69mA2uggshvUTXz/58Fu+UJ51m/6RarLkQ1y7t/BNSNkB0Lvk3h1/dV3Dz70
 xgWKwO00QkVPsRmbrZs447dVrY7yEtS6GlHXTnKv5ATY8hSOlJGgJNNrcU6/XRzmiUj0cJXpK/y
 n/e879xaQtAkUhXWf06PygyuVd/MS3xQObgM8Z7vwVpI20apUF4mVF43eOdHYbQ3mgmzDZXAul0
 tNKZ2fyPzlb+a40G8ZbqNafM2X9i+c6tuhO1FtJkoXEVOTvUi6uO5sQ8/np7GGfehDbJWzM5DMS
 q9Zsev6ymkE7y6YqRc/rnyQDp9x88AjhuJ0qz7aAa4gcnh028T9SIck5ubyiR+ITUdPrjSI9znq
 55VfaSUyXt71et5xTMUg6Ct84YDtSziEYXPjmBAd7isnQXLIWm+VhcE6AakKsSaLrbfQeD8PTEw
 EeDwCb8FDv6CJRmI7auIcK2ebjd+hNwgsr70Zgth+pD51LPJM9SsSTZOfwQSB6GKmKBt804wmHO
 j6XfhmRHhLuIrMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 20:26:54 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> As with gdb_cmd passing a plain string to a subprocess involves making
> sure the escaping is correct so the underlying shell doesn't get
> confused. Do the same as gdb_cmd and make the whole thing an array.
> 
> There are a few minor wrinkles with when args.binary is expected so
> add some comments for that.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


