Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD0CC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHx5-0006x0-OT; Thu, 20 Jun 2024 09:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKHx3-0006wa-VV
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKHx2-0004V1-Cb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718890543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VzJUInZxl8e2Hjfxh5X7VsdDG3IMmsrVBcaP6IZLKK4=;
 b=ajwJRJw0H6QY+Ns7HjasbLmC2bVQkiB6BpfItKWy2G/bDNnb1543pyMBORB/CD0jL+mwE8
 lYy7p3dD3leQ72ayCHnqItRat8F9X1XgCeUYjWeunHFi8eKTOid9b0q3XJEC0wFpGWNx/p
 p++UHKC9DM6vXO/kwtIk5mtEZOHeUwg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-XH3RvryENUSt6kICXwruIA-1; Thu,
 20 Jun 2024 09:35:39 -0400
X-MC-Unique: XH3RvryENUSt6kICXwruIA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C72919560BC; Thu, 20 Jun 2024 13:35:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 034D33000218; Thu, 20 Jun 2024 13:35:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED05021E64CD; Thu, 20 Jun 2024 15:35:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Victor Toso de
 Carvalho <victortoso@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Peter Xu <peterx@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,  Jiri Pirko <jiri@resnulli.us>,  Alex Williamson
 <alex.williamson@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
In-Reply-To: <87wmmlyu64.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 19 Jun 2024 14:49:07 +0200")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87wmmlyu64.fsf@pond.sub.org>
Date: Thu, 20 Jun 2024 15:35:32 +0200
Message-ID: <87iky3u47v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:

[...]

>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index b3de1fb6b3a..57598331c5c 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json

[...]

>> @@ -631,8 +632,8 @@
>>  # Errors:
>>  #     - If hybrid suspend is not supported, Unsupported
>>  #
>> -# Notes: It's strongly recommended to issue the guest-sync command
>> -#     before sending commands when the guest resumes
>> +# .. note:: It's strongly recommended to issue the guest-sync command
>> +#    before sending commands when the guest resumes.
>>  #
>>  # Since: 1.1
>>  ##
>> @@ -1461,16 +1462,15 @@
>>  #     * POSIX: as defined by os-release(5)
>>  #     * Windows: contains string "server" or "client"
>>  #
>> -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
>> -#     @version, @version-id, @variant and @variant-id follow the
>> -#     definition specified in os-release(5). Refer to the manual page
>> -#     for exact description of the fields.  Their values are taken
>> -#     from the os-release file.  If the file is not present in the
>> -#     system, or the values are not present in the file, the fields
>> -#     are not included.
>> +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>> +#    @version, @version-id, @variant and @variant-id follow the
>> +#    definition specified in os-release(5). Refer to the manual page for
>> +#    exact description of the fields.  Their values are taken from the
>> +#    os-release file.  If the file is not present in the system, or the
>> +#    values are not present in the file, the fields are not included.
>>  #
>> -#     On Windows the values are filled from information gathered from
>> -#     the system.
>> +#    On Windows the values are filled from information gathered from
>> +#    the system.
>
> Please don't change the indentation here.  I get the same output with
>
>   @@ -1461,7 +1462,7 @@
>    #     * POSIX: as defined by os-release(5)
>    #     * Windows: contains string "server" or "client"
>    #
>   -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
>   +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>    #     @version, @version-id, @variant and @variant-id follow the
>    #     definition specified in os-release(5). Refer to the manual page
>    #     for exact description of the fields.  Their values are taken

I'm blind.  Actually, you change indentation of subsequent lines from 4
to 3 *everywhere*.  I guess you do that to make subsequent lines line up
with the directive, here "note".

Everywhere else, we indent such lines by 4.  Hmm.  How terrible would it
be not to mess with the alignment?

If we want to use 3 for directives, is it worth pointing out in the
commit message?

[...]


