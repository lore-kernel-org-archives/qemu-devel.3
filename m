Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECC9EFB815
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 08:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vunoX-0004Bt-CH; Tue, 24 Feb 2026 03:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vunoW-0004BZ-9m
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 03:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vunoT-0004zi-HQ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 03:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771921836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KunaySrgauL6ZoiAmuds4R/IoC9nCaJ+ADBjBHYhAA=;
 b=MOiRhhBayPCYMBzI/8FBdxWRjaIbG1Ku3iWzaZLzZEaM9RACmt3UXksL5RWlk89IW7HN/Q
 QCLbSFcj4veaLlzQ02xJUCA5I5KSL9fZW98JzVEITY6ZHlRnORVZkujDg/eeMeBgY51san
 pgAJQXu7MI5W2fnlmsf24SnMubBg1js=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-XF9zJ_ziNbuQM2Ml-pNfXA-1; Tue,
 24 Feb 2026 03:30:31 -0500
X-MC-Unique: XF9zJ_ziNbuQM2Ml-pNfXA-1
X-Mimecast-MFC-AGG-ID: XF9zJ_ziNbuQM2Ml-pNfXA_1771921828
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6709218003F6; Tue, 24 Feb 2026 08:30:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3941430001BB; Tue, 24 Feb 2026 08:30:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DBF6621E692D; Tue, 24 Feb 2026 09:30:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/2] block/curl: add support for S3 presigned URLs
In-Reply-To: <aZwXB5uY1a9cWlvg@wellsley> (Antoine Damhet's message of "Mon, 23
 Feb 2026 18:18:50 +0100")
References: <20260212162730.440855-1-adamhet@scaleway.com>
 <20260212162730.440855-3-adamhet@scaleway.com>
 <878qcroio8.fsf@pond.sub.org> <aZwXB5uY1a9cWlvg@wellsley>
Date: Tue, 24 Feb 2026 09:30:24 +0100
Message-ID: <87h5r65ysf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Antoine Damhet <adamhet@scaleway.com> writes:

> On Tue, Feb 17, 2026 at 09:53:11AM +0100, Markus Armbruster wrote:
>> Antoine Damhet <adamhet@scaleway.com> writes:
>> 
>> > S3 presigned URLs are signed for a specific HTTP method (typically GET
>> > for our use cases). The curl block driver currently issues a HEAD
>> > request to discover the backend features and the file size, which fails
>> > with 403.
>> >
>> > Add a 'force-range' option that skips the HEAD request and instead
>> > issues a minimal GET request (querying 1 byte from the server) to
>> > extract the file size from the 'Content-Range' response header. To
>> > achieve this the 'curl_header_cb' is redesigned to generically parse
>> > HTTP headers.
>> >
>> > $ $QEMU -drive driver=http,\
>> >              'url=https://s3.example.com/some.img?X-Amz-Security-Token=XXX',
>> >              force-range=true
>> >
>> > Enabling the 'force-range' option without the backend supporting it is
>> > undefined behavior and untested
>> 
>> "Undefined behavior" suggests it could do anything, even destroy data.
>> I hope that's not the case.  What is the case?
>> 
>> What is "the backend"?  The web server specified with @url?
>
> Undefined behavior was probably too strong of a wording. I have done way
> more tests and have a clearer picture of what happens:
>
> The web server for @url will respond with `HTTP 200` and try to send the
> whole file. Since we specified `CURLOPT_NOBODY` to the libcurl it stops
> reading the socket after the headers and justs shuts it down. The
> `force-range` mode is transparent for the user even if it can wastes a
> few TCP packets.
>
> I'll rewrite the commit message to reflect the actual behavior of the
> option in the v2.

Thanks!

>> >                                 but the libcurl should ignore the body
>> > and stop reading after the HTTP headers then we would fail with the
>> > expected `Server does not support 'range' (byte ranges).` error.
>> >
>> > Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
>> > ---
>> 
>> [...]
>> 
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index b82af7425614..ff018c2d6bfb 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -4582,12 +4582,17 @@
>> >  # @cookie-secret: ID of a QCryptoSecret object providing the cookie
>> >  #     data in a secure way.  See @cookie for the format.  (since 2.10)
>> >  #
>> > +# @force-range: Don't issue a HEAD HTTP request to discover if the
>> > +#     backend supports range requests and rely only on GET requests.
>> > +#     This is especially useful for S3 presigned URLs.  (since 11.0)

Missing: Defaults to false.

>> Unlike the commit message, this doesn't mention the need for "the
>> backend" (whatever that may be) supporting it.
>
> Will rephrase "the  backend" with "the http server". Should I document
> the behavior of the http server missing the range requests here or is
> the current description sufficient ?

What do users need to know here?  I think it's when and why to use
@force-range.  Drawbacks of using it if there are any.

>> > +#
>> >  # Since: 2.9
>> >  ##
>> >  { 'struct': 'BlockdevOptionsCurlHttp',
>> >    'base': 'BlockdevOptionsCurlBase',
>> >    'data': { '*cookie': 'str',
>> > -            '*cookie-secret': 'str'} }
>> > +            '*cookie-secret': 'str',
>> > +            '*force-range': 'bool'} }
>> >  
>> >  ##
>> >  # @BlockdevOptionsCurlHttps:
>> > @@ -4605,13 +4610,18 @@
>> >  # @cookie-secret: ID of a QCryptoSecret object providing the cookie
>> >  #     data in a secure way.  See @cookie for the format.  (since 2.10)
>> >  #
>> > +# @force-range: Don't issue a HEAD HTTP request to discover if the
>> > +#     backend supports range requests and rely only on GET requests.
>> > +#     This is especially useful for S3 presigned URLs.  (since 11.0)
>> > +#
>> >  # Since: 2.9
>> >  ##
>> 
>> @force-range is is duplicated between BlockdevOptionsCurlHttp and
>> BlockdevOptionsCurlHttps.  @cookie and @cookie-secret is already
>> duplicated before the patch.  Time to factor out a common base type?
>
> This would be only on the QAPI ? looking something like:
>
> ```
>  { 'struct': 'BlockdevOptionsCurlHttps',
> -  'base': 'BlockdevOptionsCurlBase',
> -  'data': { '*cookie': 'str',
> -            '*sslverify': 'bool',
> -            '*cookie-secret': 'str',
> -            '*force-range': 'bool'} }
> +  'base': 'BlockdevOptionsCurlHttp',
> +  'data': { '*sslverify': 'bool' } }
> ```

Looks good to me.

> ? Would you rather see this in a separate commit or is the same patch OK
> ?

I'd prefer a separate commit.


