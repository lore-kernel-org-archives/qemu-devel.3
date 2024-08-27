Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B45C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 07:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siqGU-0004e1-BC; Tue, 27 Aug 2024 03:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1siqGS-0004Yb-V2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 03:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1siqGQ-0000Ik-5q
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 03:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724742313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MVBuTQ6Dx0gE2PW77sOt8KSvzvhMXWFVpkDlV3obiQ=;
 b=YWco3xqPl7Vo0xuIg0IaMJvFL8sTEU55q2OlfPJ7b8XZ7GzYEhIwCXZK0Q2/lcWPY/u1We
 FSZ7RrqeUCLzwSF2lzBFb+SISSQILBwN0YFTy1oRQxhbJ3X21+n2wEzApV2KbdI5ZWGuly
 T2YHATfc0+uu2vLWYezGAx6bQWLHx9g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-JygGUK6KMeKviKW8qQy-ew-1; Tue,
 27 Aug 2024 03:05:10 -0400
X-MC-Unique: JygGUK6KMeKviKW8qQy-ew-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C23511955BF8; Tue, 27 Aug 2024 07:05:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 125781956054; Tue, 27 Aug 2024 07:05:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0506721E6A28; Tue, 27 Aug 2024 09:05:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Eric Blake
 <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Hyman
 Huang
 <yong.huang@smartx.com>,  Qemu-block <qemu-block@nongnu.org>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PULL 10/11] crypto: push error reporting into TLS session I/O
 APIs
In-Reply-To: <ZrotVcPk1XQa53gs@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 12 Aug 2024 16:42:13 +0100")
References: <20240724094706.30396-1-berrange@redhat.com>
 <20240724094706.30396-11-berrange@redhat.com>
 <25ea7357-99e1-4fdf-9ef8-885cb7e75f47@redhat.com>
 <ZrotVcPk1XQa53gs@redhat.com>
Date: Tue, 27 Aug 2024 09:05:04 +0200
Message-ID: <87plpumonz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Aug 12, 2024 at 05:38:41PM +0200, Thomas Huth wrote:
>> On 24/07/2024 11.47, Daniel P. Berrang=C3=A9 wrote:
>> > The current TLS session I/O APIs just return a synthetic errno
>> > value on error, which has been translated from a gnutls error
>> > value. This looses a large amount of valuable information that
>> > distinguishes different scenarios.
>> >=20
>> > Pushing population of the "Error *errp" object into the TLS
>> > session I/O APIs gives more detailed error information.
>> >=20
>> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>>=20
>>  Hi Daniel!
>>=20
>> iotest 233 is failing for me with -raw now, and bisection
>> points to this commit. Output is:
>>=20
>> --- .../qemu/tests/qemu-iotests/233.out
>> +++ /tmp/qemu/tests/qemu-iotests/scratch/raw-file-233/233.out.bad
>> @@ -69,8 +69,8 @@
>>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>=20
>>  =3D=3D check TLS with authorization =3D=3D
>> -qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls=
-creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel: =
Software caused connection abort
>> -qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls=
-creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel: =
Software caused connection abort
>> +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls=
-creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel: =
The TLS connection was non-properly terminated.
>> +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls=
-creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel: =
The TLS connection was non-properly terminated.
>
> This is an expected change. Previously squashed the real GNUTLS error
> into ECONNABORTED:
>
> -        case GNUTLS_E_PREMATURE_TERMINATION:
> -            errno =3D ECONNABORTED;
> -            break;
>
>
> now we report the original gnutls root cause.
>
> IOW, we need to update the expected output files.

Has this been done?


